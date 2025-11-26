import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/config/env.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';
import 'package:seediq_app/src/app_widget.dart';
import 'package:seediq_app/src/data/providers/provider.dart';

part 'rest_client_provider.g.dart';

@Riverpod(keepAlive: true)
Dio restClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.options.headers['Content-Type'] = 'application/json';
  dio.interceptors.addAll([
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final localStorage = ref.read(localStorageProvider);
          final token = await localStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            final authToken = token.startsWith('Bearer ') 
                ? token 
                : 'Bearer $token';
            options.headers['Authorization'] = authToken;
          }
        } catch (_) {}

        return handler.next(options);
      },
      onError: (DioError err, handler) async {
        final response = err.response;
        if (response != null && response.statusCode == 401) {
          final localStorage = ref.read(localStorageProvider);
          final refreshToken = await localStorage.getRefreshToken();

          if (refreshToken == null || refreshToken.isEmpty) {
            await localStorage.clear();
            await ref.read(userProviderProvider).clearUser();
            appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/login',
              (r) => false,
            );
            return handler.next(err);
          }

          try {
            final refreshDio = Dio(BaseOptions(baseUrl: Env.baseUrl));
            final refreshResp = await refreshDio.post(
              '/auth/refresh',
              options: Options(headers: {
                'Authorization': refreshToken.startsWith('Bearer ') 
                    ? refreshToken 
                    : 'Bearer $refreshToken'
              }),
            );

            final data = refreshResp.data;
            final newAccess =
                data['data']?['access_token'] ?? data['data']?['accessToken'];

            if (newAccess != null && (newAccess as String).isNotEmpty) {
              await localStorage.saveAccessToken(newAccess);

              final opts = Options(
                method: err.requestOptions.method,
                headers: Map<String, dynamic>.from(err.requestOptions.headers),
              );

              final authToken = newAccess.startsWith('Bearer ') 
                  ? newAccess 
                  : 'Bearer $newAccess';
              opts.headers?['Authorization'] = authToken;

              final retryDio = Dio(BaseOptions(baseUrl: Env.baseUrl));
              final retryResponse = await retryDio.request(
                err.requestOptions.path,
                data: err.requestOptions.data,
                queryParameters: err.requestOptions.queryParameters,
                options: opts,
              );

              return handler.resolve(retryResponse);
            }
          } catch (e) {
            await localStorage.clear();
            await ref.read(userProviderProvider).clearUser();
            appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/login',
              (r) => false,
            );
            return handler.next(err);
          }

          await localStorage.clear();
          await ref.read(userProviderProvider).clearUser();
          appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
            '/login',
            (r) => false,
          );
        }

        return handler.next(err);
      },
    ),
  ]);

  return dio;
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:seediq_app/src/core/exceptions/app_exception.dart';
import 'package:seediq_app/src/core/types/result.dart';

class AuthService {
  final Dio restClient;

  AuthService({
    required this.restClient,
  });

  Future<Result<Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      final Response response = await restClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(response.data);
    } on DioException catch (e, s) {
      log(
        'Erro ao tentar fazer login',
        name: 'AuthService',
        error: e,
        stackTrace: s,
      );

      final responseData = e.response?.data;

      String message = 'Erro ao tentar fazer login.';
      if (responseData is Map && responseData['message'] != null) {
        message = responseData['message'];
      } else if (e.message != null) {
        message = e.message!;
      }

      final exception = AppException(
        message,
      );

      return Failure(exception);
    } catch (e, s) {
      log(
        'Erro inesperado no AuthService',
        name: 'AuthService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro inesperado ao fazer login.'));
    }
  }
}

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

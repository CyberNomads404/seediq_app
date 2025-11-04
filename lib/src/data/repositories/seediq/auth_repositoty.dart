import 'dart:developer';

import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/user_model.dart';
import 'package:seediq_app/src/data/services/seediq/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<Result<UserModel>> login(
    String email,
    String password,
  ) async {
    final result = await authService.login(email, password);

    switch (result) {
      case Success(value: final map):
        final user = UserModel.fromMap(map);
        return Success(user);
      case Failure(:final error):
        log(
          'Erro ao realizar login: $error',
          name: 'AuthRepository',
          error: error,
        );
        return Failure(error);
    }
  }
}
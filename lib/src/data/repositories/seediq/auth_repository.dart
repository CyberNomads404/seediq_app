import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/login_response.dart';
import 'package:seediq_app/src/data/services/seediq/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<Result<LoginResponse>> login(
    String email,
    String password,
  ) async {
    final result = await authService.login(email, password);

    switch (result) {
      case Success(value: final map):
        final loginData = LoginResponse.fromMap(map['data']);
        return Success(loginData);

      case Failure(:final error):
        return Failure(error);
    }
  }
}

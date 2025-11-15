import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/api_response.dart';
import 'package:seediq_app/src/data/models/login_response.dart';
import 'package:seediq_app/src/data/models/user_model/user_model.dart';
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

  Future<Result<UserModel>> me() async {
    final result = await authService.me();

    switch (result) {
      case Success(value: final map):
        final loginData = ApiResponse<UserModel>.fromMap(
          map,
          fromJson: (json) {
            final raw = json as Map<String, dynamic>;
            final userJson = raw['user'] ?? raw;
            return UserModel.fromMap(userJson as Map<String, dynamic>);
          },
        ).data!;
        return Success(loginData);

      case Failure(:final error):
        return Failure(error);
    }
  }

  Future<Result<void>> logout() async {
    final result = await authService.logout();

    switch (result) {
      case Success(value: _):
        return Success(null);

      case Failure(:final error):
        return Failure(error);
    }
  }
}

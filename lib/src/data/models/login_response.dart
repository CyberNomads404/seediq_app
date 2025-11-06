import 'package:seediq_app/src/data/models/user_model.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }
}

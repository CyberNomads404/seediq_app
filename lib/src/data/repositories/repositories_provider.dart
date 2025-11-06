import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/repositories/seediq/auth_repository.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

part 'repositories_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final authService = ref.read(authServiceProvider);
  return AuthRepository(authService);
}
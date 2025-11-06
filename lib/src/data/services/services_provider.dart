import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/services/local_storage/local_storage_service.dart';
import 'package:seediq_app/src/data/services/seediq/auth_service.dart';
import 'package:seediq_app/src/core/rest_client/rest_client_provider.dart';

part 'services_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(restClient: ref.read(restClientProvider));
}

@riverpod
LocalStorageService localStorage(Ref ref) {
  return LocalStorageService();
}
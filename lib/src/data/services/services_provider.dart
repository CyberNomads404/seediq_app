import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/services/camera/camera_service.dart';
import 'package:seediq_app/src/data/services/local_storage/local_storage_service.dart';
import 'package:seediq_app/src/data/services/seediq/auth_service.dart';
import 'package:seediq_app/src/core/rest_client/rest_client_provider.dart';
import 'package:seediq_app/src/data/services/seediq/category_service.dart';
import 'package:seediq_app/src/data/services/seediq/classification_service.dart';

part 'services_provider.g.dart';

@riverpod
LocalStorageService localStorage(Ref ref) {
  return LocalStorageService();
}

@riverpod
CameraService cameraService(Ref ref) {
  return CameraService();
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(restClient: ref.read(restClientProvider));
}

@riverpod
CategoryService categoryService(Ref ref) {
  return CategoryService(restClient: ref.read(restClientProvider));
}

@riverpod
ClassificationService classificationService(Ref ref) {
  return ClassificationService(restClient: ref.read(restClientProvider));
}

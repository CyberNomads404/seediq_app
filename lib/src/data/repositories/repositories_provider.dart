import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/repositories/seediq/auth_repository.dart';
import 'package:seediq_app/src/data/repositories/seediq/category_repository.dart';
import 'package:seediq_app/src/data/repositories/seediq/classification_repository.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

part 'repositories_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.read(authServiceProvider));
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  return CategoryRepository(ref.read(categoryServiceProvider));
}

@riverpod
ClassificationRepository classificationRepository(Ref ref) {
  return ClassificationRepository(ref.read(classificationServiceProvider));
}
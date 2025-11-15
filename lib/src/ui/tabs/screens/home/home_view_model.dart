import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/category_model.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';
import 'home_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    Future.microtask(() => fetchCategories());
    return const HomeState();
  }

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final categoryRepository = ref.read(categoryRepositoryProvider);
    final result = await categoryRepository.fetchCategories();

    switch (result) {
      case Success(value: final categories):
        state = state.copyWith(
          isLoading: false,
          categories: categories,
          selectedCategory: categories.isNotEmpty ? categories.first : null,
        );
        break;

      case Failure(:final error):
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }

  void selectCategory(CategoryModel category) {
    state = state.copyWith(
      selectedCategory: category,
      clearError: true,
      clearSuccess: true,
    );
  }

  void updateMessage(String? message) {
    state = state.copyWith(
      message: message,
      clearError: true,
      clearSuccess: true,
    );
  }

  Future<void> captureImage() async {
    try {
      final cameraService = ref.read(cameraServiceProvider);
      final image = await cameraService.captureImageFromCamera();

      if (image != null) {
        state = state.copyWith(
          capturedImage: image,
          clearError: true,
          clearSuccess: true,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Erro ao capturar imagem: ${e.toString()}',
      );
    }
  }

  Future<void> submitClassification() async {
    if (state.selectedCategory == null || state.capturedImage == null) {
      state = state.copyWith(
        errorMessage: 'Selecione uma categoria e capture uma imagem',
      );
      return;
    }

    state = state.copyWith(
      isSubmitting: true,
      clearError: true,
      clearSuccess: true,
    );

    final classificationRepository = ref.read(classificationRepositoryProvider);
    final result = await classificationRepository.storeClassification(
      categoryExternalId: state.selectedCategory!.externalId,
      imagePath: state.capturedImage!.path,
      message: state.message,
    );

    switch (result) {
      case Success(value: final message):
        state = state.copyWith(
          isSubmitting: false,
          successMessage: message,
          clearImage: true,
          selectedCategory: state.categories.isNotEmpty
              ? state.categories.first
              : null,
          message: null,
        );
        break;

      case Failure(:final error):
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void clearSuccess() {
    state = state.copyWith(clearSuccess: true);
  }
}

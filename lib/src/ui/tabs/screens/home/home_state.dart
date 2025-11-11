import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:seediq_app/src/data/models/category_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final File? capturedImage;

  const HomeState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.categories = const [],
    this.selectedCategory,
    this.capturedImage,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    File? capturedImage,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearImage = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      capturedImage: clearImage ? null : (capturedImage ?? this.capturedImage),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSubmitting,
    errorMessage,
    successMessage,
    categories,
    selectedCategory,
    capturedImage,
  ];
}

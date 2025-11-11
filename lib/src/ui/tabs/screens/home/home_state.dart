import 'package:equatable/equatable.dart';
import 'package:seediq_app/src/data/models/category_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
    this.selectedCategory,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, categories, selectedCategory];
}

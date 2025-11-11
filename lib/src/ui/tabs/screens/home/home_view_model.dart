import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/category_model.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'home_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    _loadCategories();
    return const HomeState(isLoading: true);
  }

  Future<void> _loadCategories() async {
    final categoryRepository = ref.read(categoryRepositoryProvider);

    final result = await categoryRepository.fetchCategories();
    switch (result) {
      case Success(value: final data):
        state = state.copyWith(
          isLoading: false,
          categories: data,
          selectedCategory: data.isNotEmpty ? data.first : null,
        );
        return;

      case Failure(:final error):
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
        return;
    }
  }

  void selectCategory(CategoryModel category) {
    state = state.copyWith(selectedCategory: category);
  }
}

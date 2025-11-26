import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';
import 'package:seediq_app/src/data/models/api_response.dart';
import 'package:seediq_app/src/data/models/category_model.dart';
import 'package:seediq_app/src/data/services/seediq/category_service.dart';

class CategoryRepository {
  final CategoryService categoryService;

  CategoryRepository(this.categoryService);

  Future<Result<List<CategoryModel>>> fetchCategories() async {
    final result = await categoryService.fetchCategories();

    switch (result) {
      case Success(value: final map):
        final categoriesData = ApiResponse<CategoryData>.fromMap(
            map,
            fromJson: CategoryData.fromJson,
          );

        return Success(categoriesData.data!.categories);
      case Failure(:final error):
        return Failure(error);
    }
  }
}

class CategoryData {
  final List<CategoryModel> categories;

  CategoryData({required this.categories});

  factory CategoryData.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CategoryData(
      categories: (map['categories'] as List?)
              ?.map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
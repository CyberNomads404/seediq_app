import 'package:seediq_app/src/core/types/result.dart';
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
        final categoriesData = ApiResponse.fromMap(map);
        return Success(categoriesData.data.categories
            .map<CategoryModel>((e) => CategoryModel.fromMap(e))
            .toList());
      case Failure(:final error):
        return Failure(error);
    }
  }
}
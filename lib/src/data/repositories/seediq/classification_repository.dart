import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/api_response.dart';
import 'package:seediq_app/src/data/models/category_model.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';
import 'package:seediq_app/src/data/services/seediq/classification_service.dart';

class ClassificationRepository {
  final ClassificationService classificationService;

  ClassificationRepository(this.classificationService);

  Future<Result<List<ClassificationModel>>> fetchClassifications() async {
    final result = await classificationService.fetchClassifications();

    switch (result) {
      case Success(value: final map):
        final categoriesData = ApiResponse.fromMap(map);
        return Success(
          categoriesData.data.categories
              .map<ClassificationModel>((e) => ClassificationModel.fromMap(e))
              .toList(),
        );
      case Failure(:final error):
        return Failure(error);
    }
  }

  Future<Result<ClassificationModel>> fetchClassificationDetails(
    String externalId,
  ) async {
    final result = await classificationService.fetchClassificationDetails(
      externalId,
    );

    switch (result) {
      case Success(value: final map):
        final categoryData = ApiResponse.fromMap(map);
        return Success(categoryData.data);
      case Failure(:final error):
        return Failure(error);
    }
  }

  Future<Result<String>> storeClassification({
    required String categoryExternalId,
    required String imagePath,
    String? message,
  }) async {
    final result = await classificationService.storeClassification(
      categoryExternalId: categoryExternalId,
      imagePath: imagePath,
      message: message,
    );

    switch (result) {
      case Success(value: final map):
        final categoryData = ApiResponse.fromMap(map);
        return Success(categoryData.message);
      case Failure(:final error):
        return Failure(error);
    }
  }
}

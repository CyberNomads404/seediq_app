import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/api_response.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';
import 'package:seediq_app/src/data/services/seediq/classification_service.dart';

class ClassificationRepository {
  final ClassificationService classificationService;

  ClassificationRepository(this.classificationService);

  Future<Result<List<ClassificationModel>>> fetchClassifications() async {
    final result = await classificationService.fetchClassifications();

    switch (result) {
      case Success(value: final map):
        final classificationsData = ApiResponse<ClassificationData>.fromMap(
            map,
            fromJson: ClassificationData.fromJson,
          );
        
        return Success(classificationsData.data!.categories);
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
        final classificationData = ApiResponse<ClassificationModel>.fromMap(
          map,
          fromJson: (json) {
            final raw = json as Map<String, dynamic>;
            final classificationRow = raw;
            return ClassificationModel.fromMap(classificationRow);
          },
        ).data!;

        return Success(classificationData);
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

class ClassificationData {
  final List<ClassificationModel> categories;

  ClassificationData({required this.categories});

  factory ClassificationData.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return ClassificationData(
      categories: (map['classifications'] as List?)
              ?.map((e) => ClassificationModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
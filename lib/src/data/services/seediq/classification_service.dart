import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:seediq_app/src/core/exceptions/app_exception.dart';
import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';

class ClassificationService {
  final Dio restClient;

  ClassificationService({
    required this.restClient,
  });

  Future<Result<Map<String, dynamic>>> fetchClassifications({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await restClient.get(
        '/classifications',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      return Success(response.data);
    } catch (e, s) {
      log(
        'Erro inesperado no ClassificationService',
        name: 'ClassificationService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro ao buscar classificações.'));
    }
  }

  Future<Result<Map<String, dynamic>>> fetchClassificationDetails(
    String externalId,
  ) async {
    try {
      final Response response = await restClient.get(
        '/classifications/$externalId',
      );

      return Success(response.data);
    } catch (e, s) {
      log(
        'Erro inesperado no ClassificationService',
        name: 'ClassificationService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro ao buscar detalhes da classificação.'));
    }
  }

  Future<Result<Map<String, dynamic>>> storeClassification({
    required String categoryExternalId,
    required String imagePath,
    String? message,
  }) async {
    try {
      final file = File(imagePath);
      final exists = await file.exists();
      if (!exists) {
        return Failure(
          AppException('Arquivo de imagem não encontrado: $imagePath'),
        );
      }

      final formData = FormData.fromMap({
        'category_external_id': categoryExternalId,
        'file': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
        if (message != null) 'message': message,
      });

      final Response response = await restClient.post(
        '/classifications',
        data: formData,
      );

      return Success(response.data);
    } catch (e, s) {
      log(
        'Erro inesperado no ClassificationService',
        name: 'ClassificationService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro ao criar uma classificação.'));
    }
  }

  Future<Result<Map<String, dynamic>>> reanalyzeClassification(
    String externalId,
  ) async {
    try {
      final Response response = await restClient.put(
        '/classifications/$externalId/reanalyze',
      );

      return Success(response.data);
    } catch (e, s) {
      log(
        'Erro inesperado no ClassificationService',
        name: 'ClassificationService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro ao reanalisar a classificação.'));
    }
  }
}

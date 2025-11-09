import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seediq_app/src/core/exceptions/app_exception.dart';
import 'package:seediq_app/src/core/types/result.dart';

class ClassificationService {
  final Dio restClient;

  ClassificationService({
    required this.restClient,
  });

  Future<Result<Map<String, dynamic>>> fetchClassifications() async {
    try {
      final Response response = await restClient.get('/classifications');

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

  Future<Result<Map<String, dynamic>>> storeClassification() async {
    try {
      final Response response = await restClient.post('/classifications');

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
}

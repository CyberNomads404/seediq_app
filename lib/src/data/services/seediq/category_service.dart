import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seediq_app/src/core/exceptions/app_exception.dart';
import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';

class CategoryService {
  final Dio restClient;

  CategoryService({
    required this.restClient,
  });

  Future<Result<Map<String, dynamic>>> fetchCategories() async {
    try {
      final Response response = await restClient.get('/categories');

      return Success(response.data);
    } catch (e, s) {
      log(
        'Erro inesperado no CategoryService',
        name: 'CategoryService',
        error: e,
        stackTrace: s,
      );
      return Failure(AppException('Erro ao buscar categorias.'));
    }
  }
}

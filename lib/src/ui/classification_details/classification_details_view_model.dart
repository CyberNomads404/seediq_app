import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/ui/classification_details/classification_details_state.dart';

part 'classification_details_view_model.g.dart';

@riverpod
class ClassificationDetailsViewModel extends _$ClassificationDetailsViewModel {
  @override
  ClassificationDetailsState build() {
    Future.microtask(() => fetchClassificationDetails('some_external_id'));
    return const ClassificationDetailsState();
  }

  Future<void> fetchClassificationDetails(String externalId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final classificationRepository = ref.read(classificationRepositoryProvider);
    final result = await classificationRepository.fetchClassificationDetails(
      externalId,
    );

    switch (result) {
      case Success(value: final classification):
        state = state.copyWith(
          isLoading: false,
          classification: classification,
        );
        break;
      case Failure(error: final error):
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/ui/tabs/screens/history/history_state.dart';

part 'history_view_page.g.dart';

@riverpod
class HistoryViewModel extends _$HistoryViewModel {
  @override
  HistoryState build() {
    Future.microtask(() => fetchClassifications());
    return const HistoryState();
  }

  Future<void> fetchClassifications() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final classificationRepository = ref.read(classificationRepositoryProvider);
    final result = await classificationRepository.fetchClassifications();

    switch (result) {
      case Success(value: final classifications):
        state = state.copyWith(
          isLoading: false,
          classifications: classifications,
        );
        break;

      case Failure(:final error):
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/ui/tabs/screens/history/history_state.dart';

part 'history_view_page.g.dart';

@riverpod
class HistoryViewModel extends _$HistoryViewModel {
  int _page = 1;
  final int _perPage = 10;

  @override
  HistoryState build() {
    Future.microtask(() => fetchClassifications(refresh: true));
    return const HistoryState();
  }

  Future<void> fetchClassifications({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      state = state.copyWith(isLoading: true, hasMore: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    final repo = ref.read(classificationRepositoryProvider);

    final result = await repo.fetchClassifications(
      page: _page,
      perPage: _perPage,
    );

    switch (result) {
      case Success(value: final list):
        state = state.copyWith(
          isLoading: false,
          classifications: refresh ? list : [...state.classifications, ...list],
          hasMore: list.length == _perPage,
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

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    _page++;

    final repo = ref.read(classificationRepositoryProvider);
    final result = await repo.fetchClassifications(page: _page, perPage: _perPage);

    switch (result) {
      case Success(value: final list):
        state = state.copyWith(
          isLoadingMore: false,
          classifications: [...state.classifications, ...list],
          hasMore: list.length == _perPage,
        );
        break;

      case Failure(:final error):
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }
}

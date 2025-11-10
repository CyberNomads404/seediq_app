import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/models/api_response.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  AsyncValue<ApiResponse?> build() {
    return const AsyncValue.data(null);
  }

  
}

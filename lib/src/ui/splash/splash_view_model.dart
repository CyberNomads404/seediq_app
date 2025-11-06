import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  String? build() {
    return null;
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    state = '/login';
  }
}
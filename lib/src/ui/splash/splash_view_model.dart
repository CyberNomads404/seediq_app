import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  String? build() {
    return null;
  }

  Future<void> checkAuthStatus() async {
    final localStorage = ref.read(localStorageProvider);

    final user = await localStorage.getUser();

    await Future.delayed(const Duration(milliseconds: 2500));
    if (user != null) {
      log('splash: user => $user');
      state = '/tabs';
      return;
    }

    state = '/login';
  }
}

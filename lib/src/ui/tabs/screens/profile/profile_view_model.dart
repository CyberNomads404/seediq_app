import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/app_widget.dart';
import 'package:seediq_app/src/core/interfaces/api_result_interface.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';
import 'package:seediq_app/src/ui/tabs/screens/profile/profile_state.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.me();

    switch (result) {
      case Success(value: final user):
        state = state.copyWith(isLoading: false, user: user);
        break;

      case Failure(:final error):
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
        break;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final authRepository = ref.read(authRepositoryProvider);
    final localStorage = ref.read(localStorageProvider);
    final result = await authRepository.logout();

    switch (result) {
      case Success(value: _):
        await localStorage.clear();
        state = state.copyWith(isLoading: false, user: null);
        appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
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

  Future<void> openBrowser(String url) async {
    final redirect = ref.read(browserServiceProvider);

    try {
      await redirect.open(url);
    } catch (e) {
      state = state.copyWith(errorMessage: "Erro ao abrir navegador");
    }
  }
}

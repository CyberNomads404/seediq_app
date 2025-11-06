import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seediq_app/src/core/types/result.dart';
import 'package:seediq_app/src/data/models/user_model.dart';
import 'package:seediq_app/src/data/repositories/repositories_provider.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  AsyncValue<UserModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> login(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    final localStorage = ref.read(localStorageProvider);

    state = const AsyncValue.loading();

    final result = await authRepository.login(email, password);
    switch (result) {
      case Success(value: final data):
        await localStorage.saveAccessToken(data.accessToken);
        await localStorage.saveRefreshToken(data.refreshToken);
        await localStorage.saveUser(data.user.toJson());

        state = AsyncValue.data(data.user);
        return;

      case Failure(:final error):
        state = AsyncValue.error(error, StackTrace.current);
        return;
    }
  }
}

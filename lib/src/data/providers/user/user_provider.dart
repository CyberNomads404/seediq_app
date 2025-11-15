import 'package:seediq_app/src/data/models/user_model/user_model.dart';
import 'package:seediq_app/src/data/services/local_storage/local_storage_service.dart';

class UserProvider {
  final LocalStorageService localStorage;

  UserProvider(this.localStorage);

  UserModel? _user;
  bool _loading = false;

  bool get isLoading => _loading;
  UserModel? get user => _user;

  Future<void> loadFromStorage() async {
    _loading = true;
    final userJson = await localStorage.getUser();
    if (userJson == null || userJson.isEmpty) {
      _user = null;
      _loading = false;
      return;
    }

    try {
      _user = UserModel.fromJson(userJson);
    } catch (_) {
      _user = null;
    }

    _loading = false;
  }

  Future<void> setUser(UserModel user) async {
    _user = user;
    await localStorage.saveUser(user.toJson());
  }

  Future<void> clearUser() async {
    _user = null;
    await localStorage.clear();
  }
}

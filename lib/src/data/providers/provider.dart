
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/data/providers/user/user_provider.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

UserProvider userProvider(Ref ref) {
  return UserProvider(ref.read(localStorageProvider));
}
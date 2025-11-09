import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env') 
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'DEBUG', defaultValue: false)
  static const bool debug = _Env.debug == 'true';
}

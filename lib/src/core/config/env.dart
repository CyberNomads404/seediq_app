import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env') 
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'FRONT_BASE_URL')
  static const String frontBaseUrl = _Env.frontBaseUrl;

  @EnviedField(varName: 'DEBUG', defaultValue: false)
  static const bool debug = _Env.debug == 'true';
}

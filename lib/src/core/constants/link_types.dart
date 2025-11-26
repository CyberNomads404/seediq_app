import 'package:seediq_app/src/core/config/env.dart';

class LinkTypes {
  static const String resetPassword = "${Env.frontBaseUrl}auth/forgot-password";
  static const String verifyEmail = "${Env.frontBaseUrl}auth/verify-email";

  static const String faq = "${Env.frontBaseUrl}faq";
  static const String termsOfUse = "${Env.frontBaseUrl}terms-of-use";
  static const String privacyPolicy = "${Env.frontBaseUrl}privacy";
  static const String userManual = "${Env.frontBaseUrl}user-manual";
  static const String aboutUs = "https://github.com/CyberNomads404";
}

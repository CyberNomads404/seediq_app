import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String get baseUrl =>
      dotenv.env['BASE_URL']?.trim().isNotEmpty == true
          ? dotenv.env['BASE_URL']!
          : 'http://localhost/api/';

  static bool get debug =>
      dotenv.env['DEBUG']?.toLowerCase() == 'true';
}

import 'package:url_launcher/url_launcher.dart';

class BrowserService {
  Future<void> open(String url) async {
    final uri = Uri.parse(url);

    print(uri.toString());
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
      );
    } else {
      throw Exception('Não foi possível abrir o navegador');
    }
  }
}

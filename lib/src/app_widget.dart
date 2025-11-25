import 'package:flutter/material.dart';
import 'package:seediq_app/src/core/themes/app_theme.dart';
import 'package:seediq_app/src/core/config/env.dart';
import 'package:seediq_app/src/ui/classification_details/classification_details_page.dart';
import 'package:seediq_app/src/ui/login/login_page.dart';
import 'package:seediq_app/src/ui/splash/splash_page.dart';
import 'package:seediq_app/src/ui/tabs/tabs_page.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seed IQ',
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: Env.debug,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/tabs': (context) => const TabsPage(),
        '/classification_details': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final externalId = args is String ? args : null;
          return ClassificationDetailsPage(externalId: externalId);
        },
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:seediq_app/src/core/config/app_theme.dart';
import 'package:seediq_app/src/core/config/env.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seed IQ',
      debugShowCheckedModeBanner: Env.debug,
      theme: appTheme,
      initialRoute: '/',
      routes: {
      },
    );
  }
}
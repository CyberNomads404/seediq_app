import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/core/config/app_colors.dart';
import 'package:seediq_app/src/core/widgets/app_loading.dart';
import 'package:seediq_app/src/core/widgets/app_loading.dart';
import 'package:seediq_app/src/ui/login/login_view_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginViewModelProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(loginViewModelProvider, (previousState, nextState) {
      if (nextState != null) {
        Navigator.of(context).pushReplacementNamed(nextState);
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.blue,
        ),
      )
    );
  }
}
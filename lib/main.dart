import 'package:flutter/material.dart';
import 'package:resumely/app/config/app_theme.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/core/router/go_router.dart';

void main() {
  runApp(const ResumelyApp());
}

class ResumelyApp extends StatelessWidget {
  const ResumelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: AppTheme.themeData,
      themeAnimationDuration: .zero,
      themeMode: .system,
      routerConfig: goRouter,
      builder: (context, child) {
        return SafeArea(
          top: true,
          bottom: false,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

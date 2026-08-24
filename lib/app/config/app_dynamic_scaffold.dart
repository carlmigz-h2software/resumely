import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_spacing.dart';

class AppDynamicScaffold extends StatelessWidget {
  const AppDynamicScaffold({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLong,
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: children,
          ),
        ),
      ),
    );
  }
}

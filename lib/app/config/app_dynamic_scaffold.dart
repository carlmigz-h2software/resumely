import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';

class AppDynamicScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;

  const AppDynamicScaffold({
    super.key,
    required this.children,
    this.bottomNavigationBar,
    this.appBar,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding ?? AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}

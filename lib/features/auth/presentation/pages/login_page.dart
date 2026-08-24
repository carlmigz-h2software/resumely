import 'package:flutter/material.dart';
import 'package:resumely/app/config/app_dynamic_scaffold.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDynamicScaffold(
      children: [
        Center(
          child: Text(
            'Resumely',
            style: AppTextStyles.white18Bold,
            textAlign: .center,
          ),
        ),
        Form(child: Column(children: [TextField()])),
      ],
    );
  }
}

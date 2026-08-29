import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/social_auth_buttons.dart';
import 'package:resumely/app/config/app_dynamic_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SignupPage extends StatefulWidget {
  static const path = '/signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDynamicScaffold(
      children: [
        AppSpacing.v8,
        // Back link
        GestureDetector(
          onTap: () => context.pop(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 16.r,
                color: AppColors.mutedForeground,
              ),
              AppSpacing.h6,
              Text(
                AppStrings.back,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        AppSpacing.v20,

        // Logo
        Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusMd,
                boxShadow: AppColors.primaryGlow,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 20.r,
                color: AppColors.primaryForeground,
              ),
            ),
            AppSpacing.h10,
            Text(
              AppStrings.appTitle,
              style: AppTextStyles.h3,
            ),
          ],
        ),
        AppSpacing.v24,

        // Heading
        Text(
          AppStrings.createAccountTitle,
          style: AppTextStyles.h1,
        ),
        AppSpacing.v6,
        Text(
          AppStrings.createAccountSubtitle,
          style: AppTextStyles.bodySmall,
        ),
        AppSpacing.v24,

        // Form
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: AppStrings.fullName,
                hintText: AppStrings.fullNamePlaceholder,
                controller: _nameController,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Name is required';
                  return null;
                },
              ),
              AppSpacing.v14,
              CustomTextField(
                label: AppStrings.email,
                hintText: AppStrings.emailPlaceholder,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              AppSpacing.v14,
              CustomTextField(
                label: AppStrings.password,
                hintText: AppStrings.passwordLengthHint,
                controller: _passwordController,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              AppSpacing.v20,
              GradientButton(
                onPressed: _onSignup,
                text: AppStrings.createAccountTitle,
              ),
            ],
          ),
        ),
        AppSpacing.v24,

        // Divider
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.border, height: 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                AppStrings.orSignUpWith,
                style: AppTextStyles.caption,
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.border, height: 1),
            ),
          ],
        ),
        AppSpacing.v20,

        // Social Buttons
        SocialAuthButtons(
          onGooglePressed: () => context.go('/home'),
          onApplePressed: () => context.go('/home'),
          onGithubPressed: () => context.go('/home'),
        ),
        AppSpacing.v32,

        // Sign in link
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${AppStrings.alreadyHaveAccount} ',
                style: AppTextStyles.bodySmall,
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  AppStrings.signIn,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.v16,
      ],
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/social_auth_buttons.dart';
import 'package:resumely/app/config/app_dynamic_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  static const path = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthLoginSubmitted(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        } else if (state.status == AuthStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.destructive,
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      builder: (context, state) {
        return AppDynamicScaffold(
          children: [
            AppSpacing.v16,
            // App Logo & Brand Header
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
            AppSpacing.v32,

            // Welcome Text
            Text(
              AppStrings.welcomeBack,
              style: AppTextStyles.h1,
            ),
            AppSpacing.v6,
            Text(
              AppStrings.loginSubtitle,
              style: AppTextStyles.bodySmall,
            ),
            AppSpacing.v24,

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                    hintText: AppStrings.passwordPlaceholder,
                    controller: _passwordController,
                    isPassword: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password is required';
                      return null;
                    },
                  ),
                  AppSpacing.v20,
                  GradientButton(
                    onPressed: _onLogin,
                    text: AppStrings.signIn,
                    isLoading: state.status == AuthStatus.loading,
                  ),
                ],
              ),
            ),
            AppSpacing.v24,

            // Divider "or continue with"
            Row(
              children: [
                const Expanded(
                  child: Divider(color: AppColors.border, height: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    AppStrings.orContinueWith,
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

            // Bottom prompt
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${AppStrings.newHere} ',
                    style: AppTextStyles.bodySmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/signup');
                    },
                    child: Text(
                      AppStrings.createAccount,
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
      },
    );
  }
}

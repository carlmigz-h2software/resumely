import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/social_auth_buttons.dart';
import 'package:resumely/app/config/app_dynamic_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/auth/presentation/widgets/auth_divider.dart';
import 'package:resumely/features/auth/presentation/widgets/auth_header.dart';

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
            // 1. Header & Branding
            const AuthHeader(
              title: AppStrings.welcomeBack,
              subtitle: AppStrings.loginSubtitle,
            ),
            AppSpacing.v24,

            // 2. Login Form
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

            // 3. Divider
            const AuthDivider(text: AppStrings.orContinueWith),
            AppSpacing.v20,

            // 4. Social Auth Options
            SocialAuthButtons(
              onGooglePressed: () => context.go('/home'),
              onApplePressed: () => context.go('/home'),
              onGithubPressed: () => context.go('/home'),
            ),
            AppSpacing.v32,

            // 5. Sign up switch link
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

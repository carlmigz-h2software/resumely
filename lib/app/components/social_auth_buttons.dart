import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';

class SocialAuthButtons extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onGithubPressed;

  const SocialAuthButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.onGithubPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SecondaryButton(
          onPressed: onGooglePressed,
          text: AppStrings.continueWithGoogle,
          icon: Icon(Icons.g_mobiledata_rounded, size: 24.r, color: Colors.white),
        ),
        AppSpacing.v10,
        SecondaryButton(
          onPressed: onApplePressed,
          text: AppStrings.continueWithApple,
          icon: Icon(Icons.apple, size: 20.r, color: Colors.white),
        ),
        AppSpacing.v10,
        SecondaryButton(
          onPressed: onGithubPressed,
          text: AppStrings.continueWithGithub,
          icon: Icon(Icons.code_rounded, size: 20.r, color: Colors.white),
        ),
      ],
    );
  }
}

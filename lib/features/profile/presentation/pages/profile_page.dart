import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/profile/presentation/widgets/pro_upgrade_banner.dart';
import 'package:resumely/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:resumely/features/profile/presentation/widgets/settings_group_card.dart';
import 'package:resumely/features/profile/presentation/widgets/settings_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        final name = user?.name ?? 'Alex Carter';
        final email = user?.email ?? 'alex.carter@resumely.app';

        return SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.v8,
              Text(
                AppStrings.navProfile,
                style: AppTextStyles.h2,
              ),
              AppSpacing.v20,

              // 1. User Info Header Card
              ProfileHeaderCard(
                name: name,
                email: email,
              ),
              AppSpacing.v16,

              // 2. Upgrade to Pro Banner
              ProUpgradeBanner(
                onUpgrade: () => context.push('/billing'),
              ),
              AppSpacing.v24,

              // 3. Account Settings Group
              SettingsGroupCard(
                title: AppStrings.account,
                tiles: [
                  SettingsTile(
                    icon: AppIcons.fileUser,
                    title: AppStrings.personalInfo,
                    onTap: () => context.push('/personal-info'),
                  ),
                  SettingsTile(
                    icon: AppIcons.bell,
                    title: AppStrings.notifications,
                    onTap: () => context.push('/notifications'),
                  ),
                  SettingsTile(
                    icon: AppIcons.shield,
                    title: AppStrings.privacyAndSecurity,
                    onTap: () => context.push('/privacy'),
                  ),
                ],
              ),
              AppSpacing.v20,

              // 4. Resumely Group
              SettingsGroupCard(
                title: AppStrings.resumelyGroup,
                tiles: [
                  SettingsTile(
                    icon: AppIcons.creditCard,
                    title: AppStrings.billingAndPlan,
                    onTap: () => context.push('/billing'),
                  ),
                  SettingsTile(
                    icon: Icons.history_rounded,
                    title: AppStrings.exportHistory,
                    onTap: () => context.push('/export-history'),
                  ),
                  SettingsTile(
                    icon: AppIcons.circleQuestionMark,
                    title: AppStrings.helpCenter,
                    onTap: () => context.push('/help'),
                  ),
                ],
              ),
              AppSpacing.v24,

              // 5. Sign Out Button
              SecondaryButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthLogoutRequested());
                  context.go('/login');
                },
                text: AppStrings.signOut,
                icon: Icon(Icons.logout_rounded, size: 16.r, color: AppColors.destructive),
                borderColor: AppColors.destructive.withValues(alpha: 0.4),
                textStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.destructive,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpacing.v24,

              // 6. Version Footer
              Center(
                child: Text(
                  AppStrings.appVersion,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                ),
              ),
              AppSpacing.v16,
            ],
          ),
        );
      },
    );
  }
}

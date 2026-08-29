import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        final name = user?.name ?? 'Alex Carter';
        final email = user?.email ?? 'alex.carter@resumely.app';
        const title = 'Senior Product Designer';

        final initials = name
            .split(' ')
            .map((p) => p.isNotEmpty ? p[0] : '')
            .take(2)
            .join()
            .toUpperCase();

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

              // User Info Card
              CardContainer(
                isGradient: true,
                child: Row(
                  children: [
                    Container(
                      width: 56.r,
                      height: 56.r,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: AppSpacing.borderRadiusMd,
                        boxShadow: AppColors.primaryGlow,
                      ),
                      child: Center(
                        child: Text(
                          initials.isNotEmpty ? initials : 'RC',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.primaryForeground,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.h16,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            email,
                            style: AppTextStyles.caption,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            title,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.v16,

              // Upgrade to Pro Card
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38.r,
                      height: 38.r,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        size: 20.r,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    AppSpacing.h12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.upgradeToPro,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            AppStrings.upgradeSubtitle,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.h8,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryForeground,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                      ),
                      onPressed: () => context.push('/billing'),
                      child: Text(
                        AppStrings.upgrade,
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.v24,

              // Account Section
              Text(
                AppStrings.account.toUpperCase(),
                style: AppTextStyles.overline,
              ),
              AppSpacing.v8,
              CardContainer(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: AppStrings.personalInfo,
                      onTap: () => context.push('/personal-info'),
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: Icons.notifications_none_rounded,
                      title: AppStrings.notifications,
                      onTap: () => context.push('/notifications'),
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: Icons.shield_outlined,
                      title: AppStrings.privacyAndSecurity,
                      onTap: () => context.push('/privacy'),
                    ),
                  ],
                ),
              ),
              AppSpacing.v20,

              // Resumely Section
              Text(
                AppStrings.resumelyGroup.toUpperCase(),
                style: AppTextStyles.overline,
              ),
              AppSpacing.v8,
              CardContainer(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.credit_card_rounded,
                      title: AppStrings.billingAndPlan,
                      onTap: () => context.push('/billing'),
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: Icons.history_rounded,
                      title: AppStrings.exportHistory,
                      onTap: () => context.push('/export-history'),
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: AppStrings.helpCenter,
                      onTap: () => context.push('/help'),
                    ),
                  ],
                ),
              ),
              AppSpacing.v24,

              // Sign Out Button
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

              // Footer
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

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 18.r, color: AppColors.mutedForeground),
            AppSpacing.h12,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.r,
              color: AppColors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/plan_card.dart';

class BillingPage extends StatelessWidget {
  static const path = '/billing';
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Billing & plan',
      subtitle: 'Resumely',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Plan Header Banner
          Container(
            padding: EdgeInsets.all(16.r),
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
                AppIcon(
                  icon: AppIcons.crown,
                  size: 20.r,
                  color: AppColors.primaryForeground,
                  containerSize: 38.r,
                  backgroundGradient: AppColors.primaryGradient,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                AppSpacing.h12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You're on Free",
                        style: AppTextStyles.h4,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Upgrade to unlock unlimited exports and AI.',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v20,

          // Choose a Plan
          Text(
            'CHOOSE A PLAN',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          // Plan 1: Free
          const PlanCard(
            name: 'Free',
            price: '\$0',
            period: '/mo',
            features: [
              '1 resume',
              'Basic templates',
              'PDF export',
            ],
            isCurrent: true,
          ),
          AppSpacing.v10,

          // Plan 2: Pro (Highlighted)
          const PlanCard(
            name: 'Pro',
            price: '\$8',
            period: '/mo',
            features: [
              'Unlimited resumes',
              'Premium templates',
              'AI rewrites',
              'Priority support',
            ],
            isPopular: true,
          ),
          AppSpacing.v10,

          // Plan 3: Team
          const PlanCard(
            name: 'Team',
            price: '\$24',
            period: '/mo',
            features: [
              'Everything in Pro',
              '5 seats',
              'Shared templates',
              'SSO',
            ],
          ),
          AppSpacing.v24,

          // Payment Method
          Text(
            'PAYMENT METHOD',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                AppIcon(
                  icon: AppIcons.creditCard,
                  size: 20.r,
                  color: AppColors.mutedForeground,
                ),
                AppSpacing.h12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add payment method', style: AppTextStyles.bodyMedium),
                      Text('No card on file', style: AppTextStyles.caption),
                    ],
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
          AppSpacing.v20,

          // Billing History
          Text(
            'BILLING HISTORY',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(
              child: Text(
                'No invoices yet.',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ),
          AppSpacing.v24,
        ],
      ),
    );
  }
}

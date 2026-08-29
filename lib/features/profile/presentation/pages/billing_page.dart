import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

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
          const _PlanCard(
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
          const _PlanCard(
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
          const _PlanCard(
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
                Icon(Icons.credit_card_rounded, size: 20.r, color: AppColors.mutedForeground),
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
                Icon(Icons.chevron_right_rounded, size: 18.r, color: AppColors.mutedForeground),
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

class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isCurrent;
  final bool isPopular;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.isCurrent = false,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isPopular ? AppColors.primary.withValues(alpha: 0.06) : AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: isPopular ? AppColors.primary.withValues(alpha: 0.6) : AppColors.border,
          width: isPopular ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(name, style: AppTextStyles.h4),
                  if (isCurrent) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'CURRENT',
                        style: AppTextStyles.overline.copyWith(color: AppColors.success),
                      ),
                    ),
                  ],
                  if (isPopular) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'POPULAR',
                        style: AppTextStyles.overline.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(price, style: AppTextStyles.h3),
                  Text(period, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text('Billed monthly', style: AppTextStyles.caption),
          AppSpacing.v12,
          Column(
            children: features.map((f) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  children: [
                    Icon(Icons.check_rounded, size: 14.r, color: AppColors.success),
                    AppSpacing.h8,
                    Text(f, style: AppTextStyles.bodySmall),
                  ],
                ),
              );
            }).toList(),
          ),
          if (!isCurrent) ...[
            AppSpacing.v12,
            GradientButton(
              onPressed: () {},
              text: 'Upgrade to $name',
              height: 40.h,
              isGlow: isPopular,
            ),
          ],
        ],
      ),
    );
  }
}

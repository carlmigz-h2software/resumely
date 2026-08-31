import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/comparison_card.dart';

class AiGuidePage extends StatelessWidget {
  static const path = '/help/ai-guide';
  const AiGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'How does AI enhancement work?',
      subtitle: 'Help & Guides',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Overview Card
          CardContainer(
            isGradient: true,
            child: Row(
              children: [
                AppIcon(
                  icon: AppIcons.sparkles,
                  size: 28.r,
                  color: AppColors.primaryForeground,
                  containerSize: 52.r,
                  backgroundGradient: AppColors.primaryGradient,
                  boxShadow: AppColors.primaryGlow,
                ),
                AppSpacing.h16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Resume Intelligence',
                        style: AppTextStyles.h4,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Turn passive job descriptions into measurable impact statements recruiters notice immediately.',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v20,

          // 3 Core Pillars
          Text(
            '3 PILLARS OF AI ENHANCEMENT',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          const _PillarTile(
            icon: AppIcons.sparkles,
            title: '1. Action-Oriented Verbs',
            description: 'Replaces passive wording like "assisted with" or "was responsible for" with executive leadership verbs such as "Spearheaded", "Engineered", and "Orchestrated".',
          ),
          AppSpacing.v8,
          const _PillarTile(
            icon: Icons.trending_up_rounded,
            title: '2. Measurable Outcomes',
            description: 'Identifies areas where key performance indicators (KPIs), percentage boosts, and cost savings should be quantified.',
          ),
          AppSpacing.v8,
          const _PillarTile(
            icon: AppIcons.shield,
            title: '3. ATS Keyword Optimization',
            description: 'Aligns technical tools and industry terms with modern recruiter screening algorithms.',
          ),
          AppSpacing.v20,

          // Before & After Comparisons
          Text(
            'BEFORE VS. AFTER EXAMPLES',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          const ComparisonCard(
            title: 'Engineering Experience',
            beforeText: 'Worked on the frontend mobile application and fixed bugs reported by users.',
            afterText: 'Architected and shipped key features for Flutter mobile app, reducing crash rate by 42% and improving daily active engagement.',
            improvementTag: '+42% Impact',
          ),
          AppSpacing.v12,

          const ComparisonCard(
            title: 'Product Design Experience',
            beforeText: 'Responsible for making wireframes and design mockups for client websites.',
            afterText: 'Spearheaded end-to-end UX redesign across 8 core product flows, lifting checkout conversion rate by 28% in Q3.',
            improvementTag: '+28% Conversion',
          ),
          AppSpacing.v20,

          // Privacy Note
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              children: [
                AppIcon(
                  icon: AppIcons.shield,
                  size: 18.r,
                  color: AppColors.primary,
                ),
                AppSpacing.h12,
                Expanded(
                  child: Text(
                    'Your data is private. Content is processed securely and never sold or shared with third parties.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.mutedForeground,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v24,

          // Action Button
          GradientButton(
            onPressed: () => context.push('/editor'),
            text: 'Try AI in Resume Editor',
            icon: AppIcon(icon: AppIcons.sparkles, size: 16.r, color: AppColors.primaryForeground),
          ),
          AppSpacing.v20,
        ],
      ),
    );
  }
}

class _PillarTile extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String description;

  const _PillarTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(
            icon: icon,
            size: 16.r,
            color: AppColors.primary,
            containerSize: 32.r,
            backgroundColor: AppColors.secondary,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

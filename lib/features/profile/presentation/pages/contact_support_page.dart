import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';

class ContactSupportPage extends StatefulWidget {
  static const path = '/help/contact-support';
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;

  String _selectedCategory = 'Bug Report';
  bool _isUrgent = false;
  bool _isSubmitting = false;

  final List<String> _categories = const [
    'Bug Report',
    'Feature Request',
    'Billing Issue',
    'Resume Advice',
    'General',
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    _nameController = TextEditingController(text: user?.name ?? 'Alex Carter');
    _emailController = TextEditingController(text: user?.email ?? 'alex.carter@resumely.app');
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusLg),
          title: Row(
            children: [
              AppIcon(
                icon: Icons.check_circle_rounded,
                size: 24.r,
                color: AppColors.success,
              ),
              AppSpacing.h10,
              Text('Message Sent', style: AppTextStyles.h4),
            ],
          ),
          content: Text(
            'Thanks for reaching out! Our support engineering team will get back to you at ${_emailController.text.trim()} within 24 hours.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.4),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.primaryForeground,
              ),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Contact support',
      subtitle: 'Help & Support',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Direct contact card
            CardContainer(
              isGradient: true,
              child: Row(
                children: [
                  AppIcon(
                    icon: AppIcons.messageCircle,
                    size: 24.r,
                    color: AppColors.primaryForeground,
                    containerSize: 48.r,
                    backgroundGradient: AppColors.primaryGradient,
                    boxShadow: AppColors.primaryGlow,
                  ),
                  AppSpacing.h16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We are here to help',
                          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'support@resumely.app · < 24h SLA',
                          style: AppTextStyles.caption.copyWith(color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.v20,

            // Category picker
            Text(
              'ISSUE CATEGORY',
              style: AppTextStyles.overline,
            ),
            AppSpacing.v8,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surface,
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected ? AppColors.primary : AppColors.foreground,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            AppSpacing.v20,

            // Fields
            CustomTextField(
              label: 'Your Name',
              controller: _nameController,
              validator: (v) => (v == null || v.isEmpty) ? 'Name is required' : null,
            ),
            AppSpacing.v14,

            CustomTextField(
              label: 'Email Address',
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
              label: 'Subject',
              hintText: 'Brief summary of the issue',
              controller: _subjectController,
              validator: (v) => (v == null || v.isEmpty) ? 'Subject is required' : null,
            ),
            AppSpacing.v14,

            CustomTextField(
              label: 'Message Details',
              hintText: 'Describe what happened or what you need assistance with...',
              controller: _messageController,
              maxLines: 5,
              validator: (v) => (v == null || v.isEmpty) ? 'Message is required' : null,
            ),
            AppSpacing.v16,

            // Priority toggle
            CardContainer(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: Row(
                children: [
                  AppIcon(
                    icon: Icons.priority_high_rounded,
                    size: 16.r,
                    color: _isUrgent ? AppColors.destructive : AppColors.mutedForeground,
                  ),
                  AppSpacing.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Urgent Priority', style: AppTextStyles.bodyMedium),
                        Text('Mark if your job application is due today', style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isUrgent,
                    activeTrackColor: AppColors.destructive,
                    onChanged: (v) => setState(() => _isUrgent = v),
                  ),
                ],
              ),
            ),
            AppSpacing.v24,

            // Submit Button
            GradientButton(
              onPressed: _submit,
              text: 'Send Message',
              isLoading: _isSubmitting,
              icon: Icon(Icons.send_rounded, size: 16.r, color: AppColors.primaryForeground),
            ),
            AppSpacing.v24,
          ],
        ),
      ),
    );
  }
}

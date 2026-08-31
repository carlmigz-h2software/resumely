import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class CertificateItemCard extends StatelessWidget {
  final int index;
  final CertificateEntity certificate;
  final ValueChanged<CertificateEntity> onChanged;
  final VoidCallback onDelete;

  const CertificateItemCard({
    super.key,
    required this.index,
    required this.certificate,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#$index',
                style: AppTextStyles.overline.copyWith(color: AppColors.primary),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 18.r,
                  color: AppColors.mutedForeground,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
          AppSpacing.v6,
          CustomTextField(
            label: AppStrings.certificateName,
            initialValue: certificate.name,
            onChanged: (v) => onChanged(certificate.copyWith(name: v)),
          ),
          AppSpacing.v8,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: AppStrings.certificateIssuer,
                  initialValue: certificate.issuer,
                  onChanged: (v) => onChanged(certificate.copyWith(issuer: v)),
                ),
              ),
              AppSpacing.h10,
              Expanded(
                child: CustomTextField(
                  label: AppStrings.certificateYear,
                  initialValue: certificate.year,
                  onChanged: (v) => onChanged(certificate.copyWith(year: v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

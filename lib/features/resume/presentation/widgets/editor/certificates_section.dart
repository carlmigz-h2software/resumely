import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/certificate_item_card.dart';
import 'package:uuid/uuid.dart';

class CertificatesSection extends StatelessWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const CertificatesSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.certificatesAndLicenses,
      icon: AppIcons.crown,
      isOpen: isOpen,
      count: resume.certificates.length,
      onToggle: onToggle,
      child: Column(
        children: [
          for (int i = 0; i < resume.certificates.length; i++) ...[
            CertificateItemCard(
              index: i + 1,
              certificate: resume.certificates[i],
              onChanged: (updatedCert) {
                final list = List<CertificateEntity>.from(resume.certificates);
                list[i] = updatedCert;
                onChanged(resume.copyWith(certificates: list));
              },
              onDelete: () {
                final list = List<CertificateEntity>.from(resume.certificates)..removeAt(i);
                onChanged(resume.copyWith(certificates: list));
              },
            ),
            AppSpacing.v10,
          ],
          SecondaryButton(
            onPressed: () {
              const uuid = Uuid();
              final newCert = CertificateEntity(
                id: uuid.v4(),
                name: '',
                issuer: '',
                year: '',
              );
              onChanged(
                resume.copyWith(
                  certificates: [...resume.certificates, newCert],
                ),
              );
            },
            text: AppStrings.addCertificate,
            icon: Icon(Icons.add, size: 16.r, color: AppColors.mutedForeground),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.border,
          ),
        ],
      ),
    );
  }
}

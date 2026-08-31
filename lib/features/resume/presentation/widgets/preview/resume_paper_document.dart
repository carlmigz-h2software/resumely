import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/widgets/preview/preview_contact_item.dart';
import 'package:resumely/features/resume/presentation/widgets/preview/preview_doc_block.dart';

class ResumePaperDocument extends StatelessWidget {
  final ResumeEntity resume;

  const ResumePaperDocument({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.docBackground,
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resume Header Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resume.fullName.isNotEmpty ? resume.fullName : 'Your Name',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.docTextPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      resume.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.docAccent,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 4.h,
                      children: [
                        if (resume.email.isNotEmpty)
                          PreviewContactItem(
                            icon: AppIcons.mail,
                            text: resume.email,
                          ),
                        if (resume.phone.isNotEmpty)
                          PreviewContactItem(
                            icon: Icons.phone_outlined,
                            text: resume.phone,
                          ),
                        if (resume.location.isNotEmpty)
                          PreviewContactItem(
                            icon: Icons.location_on_outlined,
                            text: resume.location,
                          ),
                        if (resume.website.isNotEmpty)
                          PreviewContactItem(
                            icon: Icons.language_outlined,
                            text: resume.website,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(color: AppColors.docAccent, thickness: 1.5),
          SizedBox(height: 8.h),

          // Objective Block
          if (resume.objective.isNotEmpty) ...[
            PreviewDocBlock(
              title: 'Objective',
              child: Text(
                resume.objective,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.docTextSecondary,
                  height: 1.4,
                ),
              ),
            ),
          ],

          // Experience Block
          if (resume.experiences.isNotEmpty) ...[
            PreviewDocBlock(
              title: 'Experience',
              child: Column(
                children: resume.experiences.map((exp) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${exp.role} · ${exp.company}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.docTextPrimary,
                              ),
                            ),
                            Text(
                              '${exp.start}${exp.end.isNotEmpty ? " – ${exp.end}" : ""}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.docTextMuted,
                              ),
                            ),
                          ],
                        ),
                        if (exp.description.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            exp.description,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.docTextSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Education Block
          if (resume.educations.isNotEmpty) ...[
            PreviewDocBlock(
              title: 'Education',
              child: Column(
                children: resume.educations.map((edu) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              edu.school,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.docTextPrimary,
                              ),
                            ),
                            Text(
                              edu.degree,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.docTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${edu.start}${edu.end.isNotEmpty ? " – ${edu.end}" : ""}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.docTextMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Skills Block
          if (resume.skills.isNotEmpty) ...[
            PreviewDocBlock(
              title: 'Skills',
              child: Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: resume.skills.map((skill) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.docSkillBg,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.docSkillText,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Certificates Block
          if (resume.certificates.isNotEmpty) ...[
            PreviewDocBlock(
              title: 'Certificates & Licenses',
              child: Column(
                children: resume.certificates.map((cert) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cert.name} · ${cert.issuer}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.docTextPrimary,
                          ),
                        ),
                        Text(
                          cert.year,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.docTextMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

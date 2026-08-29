import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

class PreviewPage extends StatelessWidget {
  static const path = '/preview';
  const PreviewPage({super.key});

  Future<void> _exportPdf(BuildContext context, ResumeEntity resume) async {
    context.read<ResumeBloc>().add(
          ResumeExportRequested(
            name: '${resume.fullName.isNotEmpty ? resume.fullName : "resume"}.pdf',
          ),
        );

    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          resume.fullName.isNotEmpty ? resume.fullName : 'Your Name',
                          style: const pw.TextStyle(
                            fontSize: 22,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          resume.title,
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColor.fromInt(0xFF6E56CF),
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Row(
                          children: [
                            if (resume.email.isNotEmpty)
                              pw.Text('${resume.email}  ·  ',
                                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                            if (resume.phone.isNotEmpty)
                              pw.Text('${resume.phone}  ·  ',
                                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                            if (resume.location.isNotEmpty)
                              pw.Text(resume.location,
                                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Divider(color: const PdfColor.fromInt(0xFF6E56CF), thickness: 1.5),
              pw.SizedBox(height: 8),

              // Objective
              if (resume.objective.isNotEmpty) ...[
                pw.Text(
                  'OBJECTIVE',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromInt(0xFF6E56CF),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(resume.objective, style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 12),
              ],

              // Experience
              if (resume.experiences.isNotEmpty) ...[
                pw.Text(
                  'WORK EXPERIENCE',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromInt(0xFF6E56CF),
                  ),
                ),
                pw.SizedBox(height: 4),
                ...resume.experiences.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('${exp.role} - ${exp.company}',
                                style: const pw.TextStyle(fontSize: 10)),
                            pw.Text('${exp.start} - ${exp.end}',
                                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                          ],
                        ),
                        if (exp.description.isNotEmpty) ...[
                          pw.SizedBox(height: 2),
                          pw.Text(exp.description, style: const pw.TextStyle(fontSize: 9)),
                        ],
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
              ],

              // Education
              if (resume.educations.isNotEmpty) ...[
                pw.Text(
                  'EDUCATION',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromInt(0xFF6E56CF),
                  ),
                ),
                pw.SizedBox(height: 4),
                ...resume.educations.map(
                  (edu) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('${edu.school} (${edu.degree})',
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('${edu.start} - ${edu.end}',
                            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
              ],

              // Skills
              if (resume.skills.isNotEmpty) ...[
                pw.Text(
                  'SKILLS',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromInt(0xFF6E56CF),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(resume.skills.join(', '), style: const pw.TextStyle(fontSize: 9)),
                pw.SizedBox(height: 8),
              ],

              // Certificates
              if (resume.certificates.isNotEmpty) ...[
                pw.Text(
                  'CERTIFICATES & LICENSES',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromInt(0xFF6E56CF),
                  ),
                ),
                pw.SizedBox(height: 4),
                ...resume.certificates.map(
                  (cert) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${cert.name} - ${cert.issuer}',
                          style: const pw.TextStyle(fontSize: 9)),
                      pw.Text(cert.year, style: const pw.TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumeBloc, ResumeState>(
      builder: (context, state) {
        final resume = state.activeResume;
        if (resume == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    border: Border(
                      bottom: BorderSide(color: AppColors.border, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 18.r,
                            color: AppColors.foreground,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      AppSpacing.h12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.preview.toUpperCase(),
                              style: AppTextStyles.overline,
                            ),
                            Text(
                              resume.title.isNotEmpty ? resume.title : AppStrings.untitledResume,
                              style: AppTextStyles.h4,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      GradientButton(
                        width: 110.w,
                        height: 38.h,
                        onPressed: () => _exportPdf(context, resume),
                        text: AppStrings.exportPdf,
                        icon: Icon(Icons.download_rounded, size: 14.r, color: AppColors.primaryForeground),
                      ),
                    ],
                  ),
                ),

                // Preview Document
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: AppColors.docBackground,
                            borderRadius: AppSpacing.borderRadiusLg,
                            boxShadow: AppColors.cardShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Resume Header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resume.fullName.isNotEmpty
                                              ? resume.fullName
                                              : 'Your Name',
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
                                              _ContactItem(
                                                icon: Icons.email_outlined,
                                                text: resume.email,
                                              ),
                                            if (resume.phone.isNotEmpty)
                                              _ContactItem(
                                                icon: Icons.phone_outlined,
                                                text: resume.phone,
                                              ),
                                            if (resume.location.isNotEmpty)
                                              _ContactItem(
                                                icon: Icons.location_on_outlined,
                                                text: resume.location,
                                              ),
                                            if (resume.website.isNotEmpty)
                                              _ContactItem(
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
                                _DocBlock(
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
                                _DocBlock(
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
                                _DocBlock(
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
                                _DocBlock(
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
                                _DocBlock(
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
                        ),
                        AppSpacing.v16,
                        Text(
                          AppStrings.printTip,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.mutedForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.v24,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10.r, color: AppColors.docTextSecondary),
        SizedBox(width: 3.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 9.5.sp,
            color: AppColors.docTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _DocBlock extends StatelessWidget {
  final String title;
  final Widget child;

  const _DocBlock({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.docAccent,
            ),
          ),
          SizedBox(height: 4.h),
          child,
        ],
      ),
    );
  }
}

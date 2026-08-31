import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:resumely/features/resume/presentation/widgets/preview/preview_header.dart';
import 'package:resumely/features/resume/presentation/widgets/preview/resume_paper_document.dart';

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
                // 1. Top Header
                PreviewHeader(
                  title: resume.title,
                  onBack: () => context.pop(),
                  onExport: () => _exportPdf(context, resume),
                ),

                // 2. Preview Document Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      children: [
                        ResumePaperDocument(resume: resume),
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

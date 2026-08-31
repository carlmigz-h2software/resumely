import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/section_header.dart';
import 'package:resumely/app/components/status_badge.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/features/profile/presentation/pages/ai_guide_page.dart';
import 'package:resumely/features/profile/presentation/pages/export_guide_page.dart';
import 'package:resumely/features/profile/presentation/pages/offline_guide_page.dart';
import 'package:resumely/features/profile/presentation/widgets/comparison_card.dart';
import 'package:resumely/features/profile/presentation/widgets/guide_step_card.dart';

void main() {
  testWidgets('StatusBadge renders label correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: StatusBadge(label: 'Active'),
          ),
        ),
      ),
    );

    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('SectionHeader renders title and action text', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Sections',
              trailingText: 'See all',
              onTrailingTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Sections'), findsOneWidget);
    expect(find.text('See all'), findsOneWidget);

    await tester.tap(find.text('See all'));
    expect(tapped, isTrue);
  });

  testWidgets('AppIcon renders IconData correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: AppIcon(icon: Icons.check),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('GuideStepCard renders step number, title and description', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: GuideStepCard(
              stepNumber: 1,
              title: 'Fill out details',
              description: 'Enter your personal info and job role',
              icon: Icons.edit,
            ),
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Fill out details'), findsOneWidget);
    expect(find.text('Enter your personal info and job role'), findsOneWidget);
  });

  testWidgets('ComparisonCard renders before, after and tag', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: ComparisonCard(
              title: 'Work Bullet',
              beforeText: 'Fixed software bugs',
              afterText: 'Resolved 50+ critical issues boosting uptime',
              improvementTag: '+99% Quality',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Work Bullet'), findsOneWidget);
    expect(find.text('Fixed software bugs'), findsOneWidget);
    expect(find.text('Resolved 50+ critical issues boosting uptime'), findsOneWidget);
    expect(find.text('+99% Quality'), findsOneWidget);
  });

  testWidgets('ExportGuidePage renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: ExportGuidePage(),
        ),
      ),
    );

    expect(find.text('How to export to PDF?'), findsOneWidget);
    expect(find.text('Crisp, Vector PDF Export'), findsOneWidget);
  });

  testWidgets('AiGuidePage renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: AiGuidePage(),
        ),
      ),
    );

    expect(find.text('How does AI enhancement work?'), findsOneWidget);
    expect(find.text('AI Resume Intelligence'), findsOneWidget);
  });

  testWidgets('OfflineGuidePage renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: OfflineGuidePage(),
        ),
      ),
    );

    expect(find.text('Offline editing support'), findsOneWidget);
    expect(find.text('Local-First Architecture'), findsOneWidget);
  });

  test('AppIcons constant paths are defined', () {
    expect(AppIcons.house, contains('house.svg'));
    expect(AppIcons.fileText, contains('file-text.svg'));
    expect(AppIcons.user, contains('user.svg'));
    expect(AppIcons.sparkles, contains('sparkles.svg'));
    expect(AppIcons.crown, contains('crown.svg'));
  });
}

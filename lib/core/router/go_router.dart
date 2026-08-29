import 'package:go_router/go_router.dart';
import 'package:resumely/features/auth/presentation/pages/login_page.dart';
import 'package:resumely/features/auth/presentation/pages/signup_page.dart';
import 'package:resumely/features/home/presentation/pages/main_navigation_page.dart';
import 'package:resumely/features/profile/presentation/pages/billing_page.dart';
import 'package:resumely/features/profile/presentation/pages/export_history_page.dart';
import 'package:resumely/features/profile/presentation/pages/help_page.dart';
import 'package:resumely/features/profile/presentation/pages/notifications_page.dart';
import 'package:resumely/features/profile/presentation/pages/personal_info_page.dart';
import 'package:resumely/features/profile/presentation/pages/privacy_page.dart';
import 'package:resumely/features/resume/presentation/pages/editor_page.dart';
import 'package:resumely/features/resume/presentation/pages/preview_page.dart';

final goRouter = GoRouter(
  initialLocation: LoginPage.path,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: LoginPage.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: SignupPage.path,
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: MainNavigationPage.path,
      builder: (context, state) => const MainNavigationPage(),
    ),
    GoRoute(
      path: EditorPage.path,
      builder: (context, state) => const EditorPage(),
    ),
    GoRoute(
      path: PreviewPage.path,
      builder: (context, state) => const PreviewPage(),
    ),
    GoRoute(
      path: BillingPage.path,
      builder: (context, state) => const BillingPage(),
    ),
    GoRoute(
      path: PersonalInfoPage.path,
      builder: (context, state) => const PersonalInfoPage(),
    ),
    GoRoute(
      path: NotificationsPage.path,
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: PrivacyPage.path,
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      path: ExportHistoryPage.path,
      builder: (context, state) => const ExportHistoryPage(),
    ),
    GoRoute(
      path: HelpPage.path,
      builder: (context, state) => const HelpPage(),
    ),
  ],
);

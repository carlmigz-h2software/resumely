import 'package:go_router/go_router.dart';
import 'package:resumely/features/auth/presentation/pages/login_page.dart';

final goRouter = GoRouter(
  initialLocation: LoginPage.path,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: LoginPage.path,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
  ],
);

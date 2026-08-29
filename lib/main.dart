import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/config/app_theme.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/core/di/injection_container.dart';
import 'package:resumely/core/router/go_router.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initDependencies();
  FlutterNativeSplash.remove();
  runApp(const ResumelyApp());
}

class ResumelyApp extends StatelessWidget {
  const ResumelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) =>
                  sl<AuthBloc>()..add(const AuthCheckRequested()),
            ),
            BlocProvider<ResumeBloc>(
              create: (context) =>
                  sl<ResumeBloc>()..add(const ResumeLoadActiveRequested()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: AppTheme.themeData,
            themeAnimationDuration: Duration.zero,
            themeMode: ThemeMode.dark,
            routerConfig: goRouter,
            builder: (context, routerChild) {
              return SafeArea(
                top: false,
                bottom: true,
                child: routerChild ?? const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }
}

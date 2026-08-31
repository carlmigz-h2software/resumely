import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resumely/core/network/dio_client.dart';
import 'package:resumely/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:resumely/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:resumely/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:resumely/features/auth/domain/repositories/auth_repository.dart';
import 'package:resumely/features/auth/domain/usecases/login_usecase.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/home/data/datasources/home_local_data_source.dart';
import 'package:resumely/features/home/data/repositories/home_repository_impl.dart';
import 'package:resumely/features/home/domain/repositories/home_repository.dart';
import 'package:resumely/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:resumely/features/home/domain/usecases/get_templates_usecase.dart';
import 'package:resumely/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:resumely/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';
import 'package:resumely/features/profile/domain/usecases/get_faq_items_usecase.dart';
import 'package:resumely/features/profile/domain/usecases/get_notification_preferences_usecase.dart';
import 'package:resumely/features/profile/domain/usecases/get_plans_usecase.dart';
import 'package:resumely/features/profile/domain/usecases/save_notification_preferences_usecase.dart';
import 'package:resumely/features/resume/data/datasources/resume_local_data_source.dart';
import 'package:resumely/features/resume/data/repositories/resume_repository_impl.dart';
import 'package:resumely/features/resume/domain/repositories/resume_repository.dart';
import 'package:resumely/features/resume/domain/usecases/resume_usecases.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Hive initialization
  await Hive.initFlutter();
  final resumeBox = await Hive.openBox<String>(resumeBoxName);
  final exportsBox = await Hive.openBox<String>(exportsBoxName);

  sl.registerLazySingleton<Box<String>>(() => resumeBox, instanceName: resumeBoxName);
  sl.registerLazySingleton<Box<String>>(() => exportsBox, instanceName: exportsBoxName);

  // External - SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Features - Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl(),
      authRepository: sl(),
    ),
  );

  // Features - Home
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<GetHomeDashboardUseCase>(
    () => GetHomeDashboardUseCase(sl()),
  );
  sl.registerLazySingleton<GetTemplatesUseCase>(
    () => GetTemplatesUseCase(sl()),
  );

  // Features - Profile
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<GetPlansUseCase>(
    () => GetPlansUseCase(sl()),
  );
  sl.registerLazySingleton<GetFaqItemsUseCase>(
    () => GetFaqItemsUseCase(sl()),
  );
  sl.registerLazySingleton<GetNotificationPreferencesUseCase>(
    () => GetNotificationPreferencesUseCase(sl()),
  );
  sl.registerLazySingleton<SaveNotificationPreferencesUseCase>(
    () => SaveNotificationPreferencesUseCase(sl()),
  );

  // Features - Resume
  sl.registerLazySingleton<ResumeLocalDataSource>(
    () => ResumeLocalDataSourceImpl(
      resumeBox: sl<Box<String>>(instanceName: resumeBoxName),
      exportsBox: sl<Box<String>>(instanceName: exportsBoxName),
    ),
  );
  sl.registerLazySingleton<ResumeRepository>(
    () => ResumeRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<GetActiveResumeUseCase>(
    () => GetActiveResumeUseCase(sl()),
  );
  sl.registerLazySingleton<GetAllResumesUseCase>(
    () => GetAllResumesUseCase(sl()),
  );
  sl.registerLazySingleton<SaveResumeUseCase>(
    () => SaveResumeUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteResumeUseCase>(
    () => DeleteResumeUseCase(sl()),
  );
  sl.registerLazySingleton<GetExportHistoryUseCase>(
    () => GetExportHistoryUseCase(sl()),
  );
  sl.registerLazySingleton<AddExportRecordUseCase>(
    () => AddExportRecordUseCase(sl()),
  );

  sl.registerFactory<ResumeBloc>(
    () => ResumeBloc(
      getActiveResumeUseCase: sl(),
      getAllResumesUseCase: sl(),
      saveResumeUseCase: sl(),
      deleteResumeUseCase: sl(),
      getExportHistoryUseCase: sl(),
      addExportRecordUseCase: sl(),
    ),
  );
}

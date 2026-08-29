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

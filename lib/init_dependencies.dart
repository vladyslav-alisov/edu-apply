part of 'init_dependencies.main.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // APP ENV VARIABLES
  final configLoader = DotenvConfigLoaderImpl(".env");
  await configLoader.load();

  final preferences = await SharedPreferences.getInstance();

  // Register singleton services
  _registerSingletonServices(configLoader, preferences);

  // Register data sources
  _registerDataSources();

  // Register repositories
  _registerRepositories();

  // Register use-cases
  _registerUseCases();

  // Register blocs
  _registerBlocs();
}

void _registerSingletonServices(ConfigLoader configLoader, SharedPreferences preferences) {
  serviceLocator.registerSingleton<ConfigLoader>(configLoader);
  serviceLocator.registerSingleton<SharedPreferences>(preferences);
}

void _registerDataSources() {
  serviceLocator.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceDummyImpl(),
  );
  serviceLocator.registerFactory<AuthPersistentDataSource>(
    () => AuthPersistentDataSourceSharedPreferencesImpl(prefs: serviceLocator()),
  );

  serviceLocator.registerSingleton<ProgramRemoteDataSource>(
    ProgramRemoteDataSourceDummyImpl(),
  );
  serviceLocator.registerSingleton<ProfileRemoteDataSource>(
    ProfileRemoteDataSourceDummyImpl(),
  );
  serviceLocator.registerSingleton<ApplicationRemoteDataSource>(
    ApplicationRemoteDataSourceDummyImpl(),
  );
}

void _registerRepositories() {
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      authPersistentDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<ProgramRepository>(
    () => ProgramRepositoryImpl(programRemoteDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(profileRemoteDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory<ApplicationRepository>(
    () => ApplicationRepositoryImpl(applicationRemoteDataSource: serviceLocator()),
  );
}

void _registerUseCases() {
  // Auth use cases
  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserForgotPassword(serviceLocator()));
  serviceLocator.registerFactory(() => UserTryLoginWithToken(serviceLocator()));

  // Program use cases
  serviceLocator.registerFactory(() => GetPrograms(programRepository: serviceLocator()));
  serviceLocator.registerFactory(() => GetCountries(programRepository: serviceLocator()));
  serviceLocator.registerFactory(() => GetUniversityBasicDetails(programRepository: serviceLocator()));

  // Profile use cases
  serviceLocator.registerFactory(() => ProfileFetch(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateSchool(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateLanguageCourse(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdatePersonal(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdatePassport(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateContact(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateFamily(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UploadDocument(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => DeleteDocument(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateProfileImage(profileRepository: serviceLocator()));

  // Application use cases
  serviceLocator.registerFactory(() => GetApplications(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => CreateApplication(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => DeleteApplication(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => GetLogs(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => GetFiles(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => AddFile(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => GetComments(applicationRepository: serviceLocator()));
  serviceLocator.registerFactory(() => AddComment(applicationRepository: serviceLocator()));
}

void _registerBlocs() {
  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        userForgotPassword: serviceLocator(),
        userTryLoginWithToken: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ProgramBloc(
        getPrograms: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ProfileBloc(
        uploadDocument: serviceLocator(),
        profileFetch: serviceLocator(),
        updateContact: serviceLocator(),
        updateFamily: serviceLocator(),
        updateLanguageCourse: serviceLocator(),
        updatePassport: serviceLocator(),
        updatePersonal: serviceLocator(),
        updateSchool: serviceLocator(),
        deleteDocument: serviceLocator(),
        updateProfileImage: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ApplicationBloc(
        createApplication: serviceLocator(),
        getApplications: serviceLocator(),
        deleteApplication: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(
    () => LogsBloc(
      getLogs: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => DocumentsCubit(
      addFile: serviceLocator(),
      getFiles: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => CommentsCubit(
      addComment: serviceLocator(),
      getComments: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => NavigationCubit(),
  );
}

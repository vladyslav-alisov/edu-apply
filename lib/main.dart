import 'package:edu_apply/core/bloc_observer/app_observer.dart';
import 'package:edu_apply/features/application/presentation/application/application_bloc/application_bloc.dart';
import 'package:edu_apply/features/application/presentation/comments/comments_cubit/comments_cubit.dart';
import 'package:edu_apply/features/application/presentation/files/documents_bloc/documents_cubit.dart';
import 'package:edu_apply/features/application/presentation/logs/logs_bloc/logs_bloc.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/navigation_screen/presentation/navigation_cubit/navigation_cubit.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/program/presentation/program_bloc/program_bloc.dart';
import 'package:edu_apply/init_dependencies.main.dart';
import 'package:edu_apply/init_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {
    await initDependencies();
    Bloc.observer = AppObserver();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<ProfileBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<ProgramBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<ApplicationBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<LogsBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<DocumentsCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<CommentsCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<NavigationCubit>(),
          ),
        ],
        child: const App(),
      ),
    );
  } catch (e) {
    runApp(InitErrorScreen(error: e));
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/presentation/application/application_details_screen.dart';
import 'package:edu_apply/features/application/presentation/comments/application_comments_screen.dart';
import 'package:edu_apply/features/application/presentation/files/application_files_screen.dart';
import 'package:edu_apply/features/application/presentation/logs/application_logs_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/launch_error_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:edu_apply/features/auth/presentation/screens/styled_splash_screen.dart';
import 'package:edu_apply/features/navigation_screen/presentation/screens/navigation_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/additional_documents/additional_files_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/contact/profile_contact_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/education/education_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/language_certificate/language_certificate_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/passport/passport_information_screen.dart';
import 'package:edu_apply/features/profile/presentation/screens/profile_details_screen.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/presentation/screens/program_application_overview_screen.dart';
import 'package:edu_apply/features/program/presentation/screens/program_details_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter? _goRouter;

  static GoRouter get router =>
      _goRouter == null ? throw Exception("Init router first") : _goRouter!;

  static GlobalKey get navigatorKey => _rootNavigatorKey;

  static GoRouter initRouter() {
    _goRouter ??= GoRouter(
      initialLocation: AppRoutes.init.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoutes.init.path,
          builder: (context, state) => const StyledSplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.launchInitError.path,
          builder: (context, state) =>
              LaunchErrorScreen(error: state.extra as dynamic),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: AppRoutes.signUp.path,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword.path,
          builder: (context, state) => ForgotPasswordScreen(),
        ),
        GoRoute(
          path: AppRoutes.navigation.path,
          builder: (context, state) => const NavigationScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.profileDetails.name,
              builder: (context, state) => ProfileDetailsScreen(),
            ),
            GoRoute(
              path: AppRoutes.profileContact.name,
              builder: (context, state) => ProfileContactScreen(),
            ),
            GoRoute(
              path: AppRoutes.profilePassport.name,
              builder: (context, state) => PassportInformationScreen(),
            ),
            GoRoute(
              path: AppRoutes.profileEducation.name,
              builder: (context, state) => ProfileEducationScreen(),
            ),
            GoRoute(
              path: AppRoutes.profileLanguageCertificate.name,
              builder: (context, state) => ProfileLanguageCertificateScreen(),
            ),
            GoRoute(
              path: AppRoutes.profileAdditionalDocuments.name,
              builder: (context, state) => AdditionalFilesScreen(),
            ),
            GoRoute(
              path: AppRoutes.programDetails.name,
              builder: (context, state) =>
                  ProgramDetailsScreen(program: state.extra as Program),
            ),
            GoRoute(
              path: AppRoutes.programApplicationOverview.name,
              builder: (context, state) => ProgramApplicationOverviewScreen(
                  program: state.extra as Program),
            ),
            GoRoute(
              path: AppRoutes.applicationDetails.name,
              builder: (context, state) => ApplicationDetailsScreen(
                  application: state.extra as Application),
            ),
            GoRoute(
              path: AppRoutes.applicationLogs.name,
              builder: (context, state) =>
                  ApplicationLogsScreen(applicationId: state.extra as String),
            ),
            GoRoute(
              path: AppRoutes.applicationFiles.name,
              builder: (context, state) =>
                  ApplicationFilesScreen(applicationId: state.extra as String),
            ),
            GoRoute(
              path: AppRoutes.applicationComments.name,
              builder: (context, state) => ApplicationCommentsScreen(
                  applicationId: state.extra as String),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.onboarding.path,
          builder: (context, state) => const OnboardingScreen(),
        ),
      ],
    );
    return _goRouter!;
  }
}

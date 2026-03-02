import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';

class StyledSplashScreen extends StatefulWidget {
  const StyledSplashScreen({super.key});

  @override
  State<StyledSplashScreen> createState() => _StyledSplashScreenState();
}

class _StyledSplashScreenState extends State<StyledSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).then(
      (_) => context.read<AuthBloc>().add(AuthTryLoginWithToken()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<ProfileBloc>().add(ProfileInitStarted());
            }
            if (state is AuthFailure) {
              context.go(AppRoutes.onboarding.path);
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileInitSuccess) {
              context.go(AppRoutes.navigation.path);
            }
            if (state is ProfileInitFailure) {
              context
                  .read<AuthBloc>()
                  .add(AuthProfileLoginFailed(message: state.message));
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.animations.initLoading,
                height: 400,
                width: 400,
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.loadingYourData,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

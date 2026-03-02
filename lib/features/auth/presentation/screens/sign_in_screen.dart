import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/app_bar_image.dart';
import 'package:edu_apply/core/common/widgets/styled_full_screen_loading.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/auth/presentation/widgets/auth_title_text.dart';
import 'package:edu_apply/features/auth/presentation/widgets/login_form.dart';
import 'package:edu_apply/features/auth/presentation/widgets/pressable_auth_text.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onContinuePress(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
          AuthLogin(
            email: _email.text.trim(),
            password: _password.text.trim(),
          ),
        );
  }

  void _onRegisterPress() {
    context.go(AppRoutes.signUp.path);
  }

  void _onForgotPasswordPress() {
    context.go(AppRoutes.forgotPassword.path);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
            if (state is AuthSuccess) {
              context.read<ProfileBloc>().add(ProfileInitStarted());
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileInitFailure) {
              showSnackBar(context, state.message);
              context
                  .read<AuthBloc>()
                  .add(AuthProfileLoginFailed(message: state.message));
            }
            if (state is ProfileInitSuccess) {
              context.go(AppRoutes.navigation.path);
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: kToolbarHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(14),
                              AuthTitleText(
                                title: context.l10n.login,
                                description:
                                    context.l10n.welcomeToEduApplySignIn,
                              ),
                              const Gap(48),
                              LoginForm(
                                formKey: _formKey,
                                password: _password,
                                email: _email,
                                onForgotPasswordTap: _onForgotPasswordPress,
                              ),
                              const Gap(24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _onContinuePress(context),
                                    child: Text(
                                      context.l10n.login,
                                    ),
                                  ),
                                  const Gap(24),
                                  PressableAuthText(
                                    text: context.l10n.doNotHaveAnAccount,
                                    onTextPress: _onRegisterPress,
                                    pressableText: context.l10n.register,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Gap(40),
                            Image.asset(
                              Assets.images.loginImage.path,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is AuthLoading) const StyledFullScreenLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}

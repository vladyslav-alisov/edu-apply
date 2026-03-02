import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/app_bar_image.dart';
import 'package:edu_apply/core/common/widgets/styled_full_screen_loading.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/auth/presentation/widgets/auth_title_text.dart';
import 'package:edu_apply/features/auth/presentation/widgets/password_form.dart';
import 'package:edu_apply/features/auth/presentation/widgets/personal_info_form.dart';
import 'package:edu_apply/features/auth/presentation/widgets/pressable_auth_text.dart';
import 'package:edu_apply/features/auth/presentation/widgets/styled_auth_stepper.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final ScrollController _scrollController;
  late final GlobalKey<FormState> _personalInfoFormKey;
  late final GlobalKey<FormState> _passwordFormKey;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  late Gender _selectedGender;

  late SignUpStep _signUpStep;

  @override
  void initState() {
    super.initState();
    _signUpStep = SignUpStep.personalInfo;
    _selectedGender = Gender.male;
    _scrollController = ScrollController();
    _personalInfoFormKey = GlobalKey<FormState>();
    _passwordFormKey = GlobalKey<FormState>();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _onGenderChanged(Gender gender) {
    _selectedGender = gender;
  }

  void _onContinuePress() {
    if (_signUpStep == SignUpStep.personalInfo) {
      if (!_personalInfoFormKey.currentState!.validate()) return;
      setState(() => _signUpStep = SignUpStep.password);
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    } else {
      if (!_passwordFormKey.currentState!.validate()) return;
      context.read<AuthBloc>().add(
            AuthSignUp(
              email: _email.text,
              password: _password.text,
              firstName: _firstName.text,
              lastName: _lastName.text,
              sex: _selectedGender,
              phone: _phone.text,
            ),
          );
    }
  }

  void _onBackPress() {
    setState(() => _signUpStep = SignUpStep.personalInfo);
  }

  void _onLoginPress() {
    context.go(AppRoutes.login.path);
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
                    controller: _scrollController,
                    slivers: [
                      if (_signUpStep == SignUpStep.password)
                        SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 40),
                              child: TextButton.icon(
                                onPressed: _onBackPress,
                                label: Text(
                                  context.l10n.goBack,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Color(0xFF6E6E6E),
                                ),
                              ),
                            ),
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: kToolbarHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AuthTitleText(
                                title: context.l10n.register,
                                description:
                                    context.l10n.welcomeToEduApplySignUp,
                              ),
                              const Gap(20),
                              StyledAuthStepper(
                                signUpStep: _signUpStep,
                              ),
                              const Gap(24),
                              _signUpStep == SignUpStep.personalInfo
                                  ? PersonalInfoForm(
                                      formKey: _personalInfoFormKey,
                                      firstName: _firstName,
                                      lastName: _lastName,
                                      phone: _phone,
                                      email: _email,
                                      onValueChanged: _onGenderChanged,
                                    )
                                  : PasswordForm(
                                      password: _password,
                                      confirmPassword: _confirmPassword,
                                      formKey: _passwordFormKey,
                                    ),
                              const Gap(48),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: _onContinuePress,
                                    child: Text(
                                      context.l10n.continue_,
                                    ),
                                  ),
                                  const Gap(48),
                                  PressableAuthText(
                                    text: context.l10n.alreadyHaveAnAccount,
                                    onTextPress: _onLoginPress,
                                    pressableText: context.l10n.login,
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

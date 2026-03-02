import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/app_bar_image.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_full_screen_loading.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/validator.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/auth/presentation/widgets/auth_title_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final Validator _nonEmptyValidator;
  late final TextEditingController _email;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _nonEmptyValidator = NonEmptyValidator();
    _email = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _onBackPress(BuildContext context) {
    context.go(AppRoutes.login.path);
  }

  void _onSubmitPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthForgotPassword(
              email: _email.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) showSnackBar(context, state.message);
        if (state is AuthPasswordSentSuccess) {
          showSnackBar(
            context,
            "If your email is registered, you'll receive password recovery instructions shortly.",
          );
          context.go(AppRoutes.login.path);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const AppBarImage(),
                centerTitle: false,
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 20),
                                child: TextButton.icon(
                                  onPressed: () => _onBackPress(context),
                                  label: Text(
                                    context.l10n.backToLogin,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                              ),
                            ),
                            AuthTitleText(
                              title: context.l10n.forgotPassword,
                              description: context.l10n
                                  .pleaseEnterYourEmailAddressAndWeWillDirect,
                            ),
                            const Gap(70),
                            LabeledWidget(
                              label: context.l10n.email,
                              child: TextFormField(
                                autocorrect: false,
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => _nonEmptyValidator
                                    .validate(value)
                                    ?.getErrorMessage(context),
                                decoration: InputDecoration(
                                  hintText: context.l10n.enterYourEmail,
                                ),
                              ),
                            ),
                            const Gap(50),
                            ElevatedButton(
                              onPressed: () => _onSubmitPress(context),
                              child: Text(
                                context.l10n.submit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          Assets.images.loginImage.path,
                        ),
                        const SizedBox(height: 20), // Padding at the bottom
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
    );
  }
}

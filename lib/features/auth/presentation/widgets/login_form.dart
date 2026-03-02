import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/utils/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required TextEditingController password,
    required TextEditingController email,
    required GlobalKey<FormState> formKey,
    required GestureTapCallback onForgotPasswordTap,
  })  : _password = password,
        _email = email,
        _formKey = formKey,
        _onForgotPasswordTap = onForgotPasswordTap;

  final TextEditingController _email;
  final TextEditingController _password;
  final GlobalKey<FormState> _formKey;
  final GestureTapCallback? _onForgotPasswordTap;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;

  final Validator _nonEmptyValidator = NonEmptyValidator();

  void _onPasswordObscure() => setState(() => _isObscure = !_isObscure);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          LabeledWidget(
            label: context.l10n.email,
            child: TextFormField(
              autocorrect: false,
              controller: widget._email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  _nonEmptyValidator.validate(value)?.getErrorMessage(context),
              decoration: InputDecoration(
                hintText: context.l10n.enterYourEmail,
              ),
            ),
          ),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.password,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(12),
              TextFormField(
                obscureText: _isObscure,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: widget._password,
                validator: (value) => _nonEmptyValidator
                    .validate(value)
                    ?.getErrorMessage(context),
                decoration: InputDecoration(
                  hintText: context.l10n.enterYourPassword,
                  suffixIcon: IconButton(
                    onPressed: _onPasswordObscure,
                    icon: Icon(
                      _isObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye_rounded,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: widget._onForgotPasswordTap,
                  child: Text(
                    context.l10n.forgotPassword,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

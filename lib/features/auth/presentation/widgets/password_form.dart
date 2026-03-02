import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/utils/validator.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    super.key,
    required TextEditingController password,
    required TextEditingController confirmPassword,
    required GlobalKey<FormState> formKey,
  })  : _password = password,
        _confirmPassword = confirmPassword,
        _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _password;
  final TextEditingController _confirmPassword;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _isObscure = true;
  bool _isConfirmObscure = true;

  final Validator _passwordValidator = PasswordValidator();

  void _onPasswordObscure() => setState(() => _isObscure = !_isObscure);

  void _onConfirmPasswordObscure() =>
      setState(() => _isConfirmObscure = !_isConfirmObscure);

  String? _confirmPasswordValidator(String? value) {
    String? msg = _passwordValidator.validate(value)?.getErrorMessage(context);
    if (msg != null) return msg;
    return widget._password.text == widget._confirmPassword.text
        ? null
        : "Passwords are not same";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          LabeledWidget(
            label: context.l10n.createPassword,
            child: TextFormField(
              obscureText: _isObscure,
              validator: (value) =>
                  _passwordValidator.validate(value)?.getErrorMessage(context),
              controller: widget._password,
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
          ),
          const Gap(16),
          LabeledWidget(
            label: context.l10n.confirmPassword,
            child: TextFormField(
              obscureText: _isConfirmObscure,
              validator: _confirmPasswordValidator,
              controller: widget._confirmPassword,
              decoration: InputDecoration(
                hintText: context.l10n.reEnterYourPassword,
                suffixIcon: IconButton(
                  onPressed: _onConfirmPasswordObscure,
                  icon: Icon(
                    _isConfirmObscure
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye_rounded,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

enum ValidatorError {
  emailIsIncorrect,
  passwordIsTooShort,
  passwordAreNotSame,
  empty;

  String getErrorMessage(BuildContext context) {
    return switch (this) {
      ValidatorError.emailIsIncorrect => "Email is incorrect",
      ValidatorError.passwordIsTooShort => "Password is too short",
      ValidatorError.empty => "Please enter text",
      ValidatorError.passwordAreNotSame => "Passwords are not same",
    };
  }
}

abstract class Validator {
  ValidatorError? validate(String? value);

  ValidatorError? _validateForEmpty(String? value) {
    if (value == null) return ValidatorError.empty;
    return value.trim().isEmpty ? ValidatorError.empty : null;
  }
}

class PasswordValidator extends Validator {
  @override
  ValidatorError? validate(String? value) {
    ValidatorError? emptyError = _validateForEmpty(value);
    if (emptyError != null) return emptyError;
    return null;
  }
}

class EmailAddressValidator extends Validator {
  @override
  ValidatorError? validate(String? value) {
    ValidatorError? emptyError = _validateForEmpty(value);
    if (emptyError != null) return emptyError;
    return EmailValidator.validate(value!, true) ? null : ValidatorError.emailIsIncorrect;
  }
}

class NonEmptyValidator extends Validator {
  @override
  ValidatorError? validate(String? value) {
    return _validateForEmpty(value);
  }
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/utils/validator.dart';
import 'package:edu_apply/features/auth/presentation/widgets/gender_select_dropdown.dart';

class PersonalInfoForm extends StatelessWidget {
  PersonalInfoForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required ValueChanged<Gender> onValueChanged,
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController phone,
    required TextEditingController email,
  })  : _formKey = formKey,
        _onValueChanged = onValueChanged,
        _firstName = firstName,
        _lastName = lastName,
        _phone = phone,
        _email = email;

  final GlobalKey<FormState> _formKey;

  final ValueChanged<Gender> _onValueChanged;

  final TextEditingController _firstName;

  final TextEditingController _lastName;

  final TextEditingController _phone;

  final TextEditingController _email;

  final Validator _emailValidator = EmailAddressValidator();

  final Validator _nonEmptyValidator = NonEmptyValidator();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabeledWidget(
            label: context.l10n.firstName,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _firstName,
              decoration: InputDecoration(
                hintText: context.l10n.enterYouFirstName,
              ),
              validator: (value) =>
                  _nonEmptyValidator.validate(value)?.getErrorMessage(context),
            ),
          ),
          const Gap(16),
          LabeledWidget(
            label: context.l10n.lastName,
            child: TextFormField(
              controller: _lastName,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: context.l10n.enterYourLastName,
              ),
              validator: (value) =>
                  _nonEmptyValidator.validate(value)?.getErrorMessage(context),
            ),
          ),
          const Gap(16),

          ///TODO: activate value for country
          LabeledWidget(
            label: context.l10n.phone,
            child: TextFormField(
              controller: _phone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  _nonEmptyValidator.validate(value)?.getErrorMessage(context),
              decoration: InputDecoration(
                hintText: "555 555 5555",
                prefixIcon: CountryCodePicker(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                  initialSelection: 'TR',
                  alignLeft: false,
                  showFlag: true,
                ),
              ),
            ),
          ),
          const Gap(16),
          LabeledWidget(
            label: context.l10n.email,
            child: TextFormField(
              controller: _email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: context.l10n.enterYourEmail,
              ),
              validator: (value) =>
                  _emailValidator.validate(value)?.getErrorMessage(context),
            ),
          ),
          const Gap(16),
          GenderSelectDropdown(
            initGender: Gender.male,
            onValueChanged: _onValueChanged,
          ),
        ],
      ),
    );
  }
}

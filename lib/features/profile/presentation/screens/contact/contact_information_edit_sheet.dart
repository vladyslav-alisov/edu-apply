import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/validator.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class ContactInformationEditSheet extends StatefulWidget {
  const ContactInformationEditSheet({
    super.key,
    required String? phone,
    required AvailableCountryCode? residenceCountry,
    required String? residenceCity,
    required String? residenceAddress,
    required String email,
  })  : _residenceCountry = residenceCountry,
        _residenceCity = residenceCity,
        _residenceAddress = residenceAddress,
        _phone = phone,
        _email = email;

  final AvailableCountryCode? _residenceCountry;
  final String? _residenceCity;
  final String? _residenceAddress;
  final String? _phone;
  final String? _email;

  @override
  State<ContactInformationEditSheet> createState() =>
      _ContactInformationEditSheetState();
}

class _ContactInformationEditSheetState
    extends State<ContactInformationEditSheet> {
  final NonEmptyValidator _nonEmptyValidator = NonEmptyValidator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _phoneController;
  late final TextEditingController _residenceCountryController;
  late final TextEditingController _residenceCityController;
  late final TextEditingController _residenceAddressController;

  AvailableCountryCode? _residenceCountry;

  @override
  void initState() {
    super.initState();
    _residenceCountryController =
        TextEditingController(text: widget._residenceCountry?.countryName);
    _residenceCountry = widget._residenceCountry;
    _residenceCityController =
        TextEditingController(text: widget._residenceCity);
    _residenceAddressController =
        TextEditingController(text: widget._residenceAddress);
    _phoneController = TextEditingController(text: widget._phone);
  }

  @override
  void dispose() {
    _residenceCountryController.dispose();
    _residenceCityController.dispose();
    _residenceAddressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSelectCountryPress() {
    showCountryPicker(
      context: context,
      useSafeArea: true,
      onSelect: (Country value) {
        AvailableCountryCode? newCountry =
            AvailableCountryCode.fromString(value.countryCode);
        if (newCountry == null) {
          showSnackBar(context,
              "Selected country is not supported yet. Please, contact administrator.");
        }
        if (newCountry != null) {
          _residenceCountry = newCountry;
          _residenceCountryController.text = newCountry.countryName;
        }
      },
    );
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdateContact(
              mobilePhone: _phoneController.text.trim(),
              countryOfResidence: _residenceCountry,
              cityOfResidence: _residenceCityController.text.trim(),
              address: _residenceAddressController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      onSubmitPress: _onSubmitTap,
      title: "Contact Information",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Email',
                  child: TextFormField(
                    readOnly: true,
                    initialValue: widget._email,
                  ),
                ),
                LabeledWidget(
                  label: 'Phone number',
                  child: TextFormField(
                    controller: _phoneController,
                    validator: (value) => _nonEmptyValidator
                        .validate(value)
                        ?.getErrorMessage(context),
                  ),
                ),
                LabeledWidget(
                  label: 'Country',
                  child: TextFormField(
                    readOnly: true,
                    controller: _residenceCountryController,
                    onTap: () => _onSelectCountryPress(),
                  ),
                ),
                LabeledWidget(
                  label: 'City',
                  child: TextFormField(
                    controller: _residenceCityController,
                  ),
                ),
                LabeledWidget(
                  label: 'Address',
                  child: TextFormField(
                    controller: _residenceAddressController,
                    minLines: 5,
                    maxLines: 5,
                  ),
                ),
              ],
              separator: Gap(16),
            ),
          ],
        ),
      ),
    );
  }
}

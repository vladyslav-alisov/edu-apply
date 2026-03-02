import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/validator.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/auth/presentation/widgets/gender_select_dropdown.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

enum CountryType {
  residence,
  nationality;
}

class PersonalInformationEditSheet extends StatefulWidget {
  const PersonalInformationEditSheet({
    super.key,
    required DateTime? initBirthdate,
    required Gender gender,
    required String firstName,
    required String lastName,
    required String? fatherName,
    required String? motherName,
  })  : _initBirthdate = initBirthdate,
        _initGender = gender,
        _firstName = firstName,
        _lastName = lastName,
        _fatherName = fatherName,
        _motherName = motherName;

  final DateTime? _initBirthdate;
  final Gender _initGender;
  final String _firstName;
  final String _lastName;
  final String? _fatherName;
  final String? _motherName;

  @override
  State<PersonalInformationEditSheet> createState() =>
      _PersonalInformationEditSheetState();
}

class _PersonalInformationEditSheetState
    extends State<PersonalInformationEditSheet> {
  final NonEmptyValidator _nonEmptyValidator = NonEmptyValidator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthdateController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _motherNameController;

  late Gender _selectedGender;
  DateTime? _selectedBirthdate;

  @override
  void initState() {
    super.initState();
    _selectedBirthdate = widget._initBirthdate;
    _birthdateController =
        TextEditingController(text: widget._initBirthdate?.appFormat);
    _firstNameController = TextEditingController(text: widget._firstName);
    _lastNameController = TextEditingController(text: widget._lastName);
    _selectedGender = widget._initGender;
    _fatherNameController = TextEditingController(text: widget._fatherName);
    _motherNameController = TextEditingController(text: widget._motherName);
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    super.dispose();
  }

  void _onBirthdateTap() async {
    DateTime? initDateTime = _selectedBirthdate;

    /// 100 years
    final DateTime firstDate = DateTime.now().subtract(Duration(days: 36525));

    /// 16 years
    final DateTime lastDate = DateTime.now().subtract(Duration(days: 5844));

    /// 18 years
    final DateTime defaultInitTime =
        DateTime.now().subtract(Duration(days: 6570));

    if (initDateTime == null ||
        initDateTime.isAfter(lastDate) ||
        initDateTime.isBefore(firstDate)) {
      initDateTime = defaultInitTime;
    }

    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: initDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDateTime != null) {
      _birthdateController.text = selectedDateTime.appFormat;
      setState(() => _selectedBirthdate = selectedDateTime);
    }
  }

  void _onGenderChanged(Gender gender) {
    _selectedGender = gender;
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdatePersonal(
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              birthdate: _selectedBirthdate,
              gender: _selectedGender,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      onSubmitPress: _onSubmitTap,
      title: "Personal Information",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'First name',
                  child: TextFormField(
                    controller: _firstNameController,
                    validator: (value) => _nonEmptyValidator
                        .validate(value)
                        ?.getErrorMessage(context),
                  ),
                ),
                LabeledWidget(
                  label: 'Last name',
                  child: TextFormField(
                    controller: _lastNameController,
                    validator: (value) => _nonEmptyValidator
                        .validate(value)
                        ?.getErrorMessage(context),
                  ),
                ),
                LabeledWidget(
                  label: 'Birthdate',
                  child: TextFormField(
                    controller: _birthdateController,
                    readOnly: true,
                    onTap: _onBirthdateTap,
                  ),
                ),
                GenderSelectDropdown(
                  initGender: _selectedGender,
                  onValueChanged: _onGenderChanged,
                ),
                LabeledWidget(
                  label: 'Father name',
                  child: TextFormField(
                    controller: _fatherNameController,
                  ),
                ),
                LabeledWidget(
                  label: 'Mother name',
                  child: TextFormField(
                    controller: _motherNameController,
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

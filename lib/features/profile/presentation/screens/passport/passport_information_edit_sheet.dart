import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_file_picker.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/personal_information_edit_sheet.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class PassportInformationEditSheet extends StatefulWidget {
  const PassportInformationEditSheet({
    super.key,
    required String? passportNumber,
    required DateTime? dateOfIssue,
    required DateTime? dateOfExpire,
    required AdditionalDocument? passport,
    required AvailableCountryCode? nationality,
  })  : _passportNumber = passportNumber,
        _dateOfIssue = dateOfIssue,
        _dateOfExpire = dateOfExpire,
        _passport = passport,
        _nationality = nationality;

  final String? _passportNumber;
  final DateTime? _dateOfIssue;
  final DateTime? _dateOfExpire;
  final AdditionalDocument? _passport;
  final AvailableCountryCode? _nationality;

  @override
  State<PassportInformationEditSheet> createState() =>
      _PassportInformationEditSheetState();
}

class _PassportInformationEditSheetState
    extends State<PassportInformationEditSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _passportNumberController;
  late final TextEditingController _dateOfIssueController;
  late final TextEditingController _dateOfExpireController;
  late final TextEditingController _nationalityController;

  DateTime? _dateOfExpire;
  DateTime? _dateOfIssue;
  File? _currentFile;
  bool _isPassportPickerInit = false;
  AvailableCountryCode? _nationalityCountry;

  @override
  void initState() {
    super.initState();
    _passportNumberController =
        TextEditingController(text: widget._passportNumber);
    _dateOfIssueController =
        TextEditingController(text: widget._dateOfIssue?.appFormat);
    _dateOfIssue = widget._dateOfIssue;
    _nationalityController =
        TextEditingController(text: widget._nationality?.countryName);
    _nationalityCountry = widget._nationality;
    _dateOfExpireController =
        TextEditingController(text: widget._dateOfExpire?.appFormat);
    _dateOfExpire = widget._dateOfExpire;
    _nationalityCountry = widget._nationality;
  }

  @override
  void dispose() {
    _passportNumberController.dispose();
    _dateOfExpireController.dispose();
    _dateOfIssueController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  void _onSubmitTap() {
    if (!_isPassportPickerInit) {
      showSnackBar(context, "File is not loaded yet");
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdatePassport(
              nationality: _nationalityCountry,
              passportNumber: _passportNumberController.text.trim(),
              expireDate: _dateOfExpire,
              issueDate: _dateOfIssue,
              passportFile: _currentFile,
            ),
          );
    }
  }

  void _onPassportPickerInitialized(value) {
    _isPassportPickerInit = true;
    _currentFile = value;
  }

  void _onFilePicked(File value) {
    _currentFile = value;
  }

  void _onCurrentFileDeleted() {
    _currentFile = null;
  }

  void _onPassportDateIssueTap() async {
    DateTime? initDateTime = _dateOfIssue;

    /// -15 years
    final DateTime firstDate = DateTime.now().subtract(Duration(days: 5478));

    /// +15 years
    final DateTime lastDate = DateTime.now().add(Duration(days: 5478));

    /// -5 years
    final DateTime defaultInitTime =
        DateTime.now().subtract(Duration(days: 1826));

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
      _dateOfIssueController.text = selectedDateTime.appFormat;
      setState(() => _dateOfIssue = selectedDateTime);
    }
  }

  void _onPassportDateExpiryTap() async {
    DateTime? initDateTime = _dateOfExpire;

    /// -15 years
    final DateTime firstDate = DateTime.now().subtract(Duration(days: 5478));

    /// 15 years
    final DateTime lastDate = DateTime.now().add(Duration(days: 5478));

    /// +5 years
    final DateTime defaultInitTime = DateTime.now().add(Duration(days: 1826));

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
      _dateOfExpireController.text = selectedDateTime.appFormat;
      setState(() => _dateOfExpire = selectedDateTime);
    }
  }

  void _onSelectCountryPress(CountryType countryType) {
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
          _nationalityCountry = newCountry;
          _nationalityController.text = newCountry.countryName;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      onSubmitPress: _onSubmitTap,
      title: 'Passport Information',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Nationality',
                  child: TextFormField(
                    readOnly: true,
                    controller: _nationalityController,
                    onTap: () => _onSelectCountryPress(CountryType.nationality),
                  ),
                ),
                LabeledWidget(
                  label: 'Passport number',
                  child: TextFormField(
                    controller: _passportNumberController,
                  ),
                ),
                LabeledWidget(
                  label: 'Date of issue',
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateOfIssueController,
                    onTap: _onPassportDateIssueTap,
                  ),
                ),
                LabeledWidget(
                  label: 'Date of expiry',
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateOfExpireController,
                    onTap: _onPassportDateExpiryTap,
                  ),
                ),
                LabeledWidget(
                  label: 'Passport',
                  child: StyledFilePicker(
                    initFileUrl: widget._passport?.file?.url,
                    onFilePicked: _onFilePicked,
                    onFileInitialized: _onPassportPickerInitialized,
                    onFileDeleted: _onCurrentFileDeleted,
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

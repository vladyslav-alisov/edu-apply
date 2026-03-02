import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_file_picker.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class SchoolInformationEditSheet extends StatefulWidget {
  const SchoolInformationEditSheet({
    super.key,
    required String? nameOfSchool,
    required String? degreeName,
    required AvailableCountryCode? countryCode,
    required String? cgpa,
    required String? graduationYear,
    required AdditionalDocument? diploma,
    required AdditionalDocument? transcript,
  })  : _nameOfSchool = nameOfSchool,
        _degreeName = degreeName,
        _countryCode = countryCode,
        _cgpa = cgpa,
        _graduationYear = graduationYear,
        _diploma = diploma,
        _transcript = transcript;

  final String? _nameOfSchool;
  final String? _degreeName;
  final String? _cgpa;
  final String? _graduationYear;
  final AvailableCountryCode? _countryCode;
  final AdditionalDocument? _diploma;
  final AdditionalDocument? _transcript;

  @override
  State<SchoolInformationEditSheet> createState() =>
      _SchoolInformationEditSheetState();
}

class _SchoolInformationEditSheetState
    extends State<SchoolInformationEditSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameOfSchoolController;
  late final TextEditingController _degreeNameController;
  late final TextEditingController _cgpaController;
  late final TextEditingController _graduationYearController;
  late final TextEditingController _countryCodeController;

  AvailableCountryCode? _country;
  File? _diplomaFile;
  File? _transcriptFile;
  bool _isDiplomaPickerInit = false;
  bool _isTranscriptPickerInit = false;

  bool get _pickersInitiated => _isDiplomaPickerInit && _isTranscriptPickerInit;

  @override
  void initState() {
    super.initState();
    _nameOfSchoolController = TextEditingController(text: widget._nameOfSchool);
    _degreeNameController = TextEditingController(text: widget._degreeName);
    _cgpaController = TextEditingController(text: widget._cgpa);
    _graduationYearController =
        TextEditingController(text: widget._graduationYear);
    _countryCodeController =
        TextEditingController(text: widget._countryCode?.countryName);
    _country = widget._countryCode;
  }

  @override
  void dispose() {
    _nameOfSchoolController.dispose();
    _degreeNameController.dispose();
    _cgpaController.dispose();
    _graduationYearController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  void _onSubmitTap() {
    if (!_pickersInitiated) {
      showSnackBar(context, "File is not loaded yet");
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdateSchool(
              schoolName: _nameOfSchoolController.text.trim(),
              graduationYear: _graduationYearController.text.trim(),
              degree: _degreeNameController.text.trim(),
              country: _country,
              cgpa: _cgpaController.text.trim(),
              diploma: _diplomaFile,
              transcript: _transcriptFile,
            ),
          );
    }
  }

  void _onDiplomaPickerInitialized(value) {
    _isDiplomaPickerInit = true;
    _diplomaFile = value;
  }

  void _onDiplomaFilePicked(File value) {
    _diplomaFile = value;
  }

  void _onDiplomaFileDeleted() {
    _diplomaFile = null;
  }

  void _onTranscriptPickerInitialized(value) {
    _isTranscriptPickerInit = true;
    _transcriptFile = value;
  }

  void _onTranscriptFilePicked(File value) {
    _transcriptFile = value;
  }

  void _onTranscriptFileDeleted() {
    _transcriptFile = null;
  }

  void _onGraduationYearTap() async {
    int? year = int.tryParse(_graduationYearController.text);
    DateTime? initDateTime = (year != null && year.abs().toString().length == 4)
        ? DateTime(year)
        : null;
    DateTime now = DateTime.now();

    DateTime firstDate = DateTime(now.year - 100);
    DateTime lastDate = DateTime(now.year + 100);

    if (initDateTime == null ||
        initDateTime.isAfter(lastDate) ||
        initDateTime.isBefore(firstDate)) {
      initDateTime = now;
    }

    DateTime? selectedDateTime = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: firstDate,
              lastDate: lastDate,
              selectedDate: initDateTime,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
            ),
          ),
        );
      },
    );
    if (selectedDateTime != null) {
      _graduationYearController.text = selectedDateTime.year.toString();
    }
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
          _countryCodeController.text = newCountry.countryName;
          _country = newCountry;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      title: "School Information",
      onSubmitPress: _onSubmitTap,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Name',
                  child: TextFormField(
                    controller: _nameOfSchoolController,
                  ),
                ),
                LabeledWidget(
                  label: 'Degree',
                  child: TextFormField(
                    controller: _degreeNameController,
                  ),
                ),
                LabeledWidget(
                  label: 'Country',
                  child: TextFormField(
                    controller: _countryCodeController,
                    readOnly: true,
                    onTap: () => _onSelectCountryPress(),
                  ),
                ),
                LabeledWidget(
                  label: 'CGPA',
                  child: TextFormField(
                    controller: _cgpaController,
                  ),
                ),
                LabeledWidget(
                  label: 'Graduated year',
                  child: TextFormField(
                    readOnly: true,
                    controller: _graduationYearController,
                    onTap: _onGraduationYearTap,
                  ),
                ),
                LabeledWidget(
                  label: 'Diploma',
                  child: StyledFilePicker(
                    initFileUrl: widget._diploma?.file?.url,
                    onFilePicked: _onDiplomaFilePicked,
                    onFileInitialized: _onDiplomaPickerInitialized,
                    onFileDeleted: _onDiplomaFileDeleted,
                  ),
                ),
                LabeledWidget(
                  label: 'Transcript',
                  child: StyledFilePicker(
                    initFileUrl: widget._transcript?.file?.url,
                    onFilePicked: _onTranscriptFilePicked,
                    onFileInitialized: _onTranscriptPickerInitialized,
                    onFileDeleted: _onTranscriptFileDeleted,
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

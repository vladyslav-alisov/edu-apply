import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_file_picker.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class LanguageProficiencyInformationEditSheet extends StatefulWidget {
  const LanguageProficiencyInformationEditSheet({
    super.key,
    required String? language,
    required String? grade,
    required DateTime? dateOfExam,
    required AdditionalDocument? certificate,
  })  : _language = language,
        _grade = grade,
        _dateOfExam = dateOfExam,
        _certificate = certificate;

  final String? _language;
  final String? _grade;
  final DateTime? _dateOfExam;
  final AdditionalDocument? _certificate;

  @override
  State<LanguageProficiencyInformationEditSheet> createState() =>
      _LanguageProficiencyInformationEditSheetState();
}

class _LanguageProficiencyInformationEditSheetState
    extends State<LanguageProficiencyInformationEditSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _languageController;
  late final TextEditingController _gradeController;
  late final TextEditingController _dateOfExamController;

  DateTime? _dateOfExam;
  File? _currentFile;
  bool _isCertificatePickerInit = false;

  @override
  void initState() {
    super.initState();
    _languageController = TextEditingController(text: widget._language);
    _gradeController = TextEditingController(text: widget._grade);
    _dateOfExamController =
        TextEditingController(text: widget._dateOfExam?.appFormat);
    _dateOfExam = widget._dateOfExam;
  }

  @override
  void dispose() {
    _languageController.dispose();
    _gradeController.dispose();
    _dateOfExamController.dispose();
    super.dispose();
  }

  void _onSubmitTap() {
    if (!_isCertificatePickerInit) {
      showSnackBar(context, "File is not loaded yet");
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdateLanguageCourse(
              language: _languageController.text.trim(),
              grade: _gradeController.text.trim(),
              examDate: _dateOfExam,
              certificate: _currentFile,
            ),
          );
    }
  }

  void _onCertificatePickerInitialized(value) {
    _isCertificatePickerInit = true;
    _currentFile = value;
  }

  void _onFilePicked(File value) {
    _currentFile = value;
  }

  void _onCurrentFileDeleted() {
    _currentFile = null;
  }

  void _onExamDateTap() async {
    DateTime? initDateTime = _dateOfExam;

    /// -15 years
    final DateTime firstDate = DateTime.now().subtract(Duration(days: 10000));

    /// +15 years
    final DateTime lastDate = DateTime.now().add(Duration(days: 10000));

    /// +5 years
    final DateTime defaultInitTime = DateTime.now();

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
      _dateOfExamController.text = selectedDateTime.appFormat;
      setState(() => _dateOfExam = selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      title: 'Language Proficiency',
      onSubmitPress: _onSubmitTap,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Language',
                  child: TextFormField(
                    controller: _languageController,
                  ),
                ),
                LabeledWidget(
                  label: 'Grade',
                  child: TextFormField(
                    controller: _gradeController,
                  ),
                ),
                LabeledWidget(
                  label: 'Date of exam',
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateOfExamController,
                    onTap: _onExamDateTap,
                  ),
                ),
                LabeledWidget(
                  label: 'Certificate',
                  child: StyledFilePicker(
                    initFileUrl: widget._certificate?.file?.url,
                    onFilePicked: _onFilePicked,
                    onFileInitialized: _onCertificatePickerInitialized,
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

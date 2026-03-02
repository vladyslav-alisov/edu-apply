import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_file_picker.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class AddFilesSheet extends StatefulWidget {
  const AddFilesSheet({
    super.key,
  });

  @override
  State<AddFilesSheet> createState() => _AddFilesSheetState();
}

class _AddFilesSheetState extends State<AddFilesSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _documentName;

  File? _currentFile;

  @override
  void initState() {
    super.initState();
    _documentName = TextEditingController();
  }

  @override
  void dispose() {
    _documentName.dispose();
    super.dispose();
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      File? document = _currentFile;
      if (document == null) {
        showSnackBar(context, "File is not selected");
      } else {
        context.read<ProfileBloc>().add(
              ProfileUploadDocument(
                document: document,
                documentName: _documentName.text,
              ),
            );
      }
    }
  }

  void _onFilePicked(File value) {
    _currentFile = value;
  }

  void _onCurrentFileDeleted() {
    _currentFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      onSubmitPress: _onSubmitTap,
      title: 'Additional File',
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Document name',
                  child: TextFormField(
                    controller: _documentName,
                  ),
                ),
                LabeledWidget(
                  label: 'File',
                  child: StyledFilePicker(
                    onFilePicked: _onFilePicked,
                    onFileInitialized: (value) {},
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

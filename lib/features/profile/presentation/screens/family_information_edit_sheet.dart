import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/widgets/model_edit_scaffold.dart';

class FamilyInformationEditSheet extends StatefulWidget {
  const FamilyInformationEditSheet({
    super.key,
    required String? fatherName,
    required String? motherName,
  })  : _fatherName = fatherName,
        _motherName = motherName;

  final String? _fatherName;
  final String? _motherName;

  @override
  State<FamilyInformationEditSheet> createState() =>
      _FamilyInformationEditSheetState();
}

class _FamilyInformationEditSheetState
    extends State<FamilyInformationEditSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _fatherNameController;
  late final TextEditingController _motherNameController;

  bool get _hasChanges =>
      _fatherNameController.text != widget._fatherName ||
      _motherNameController.text != widget._motherName;

  @override
  void initState() {
    super.initState();
    _fatherNameController = TextEditingController(text: widget._fatherName);
    _motherNameController = TextEditingController(text: widget._motherName);
  }

  @override
  void dispose() {
    _fatherNameController.dispose();
    _motherNameController.dispose();
    super.dispose();
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      if (_hasChanges) {
        context.read<ProfileBloc>().add(
              ProfileUpdateFamily(
                motherFirstName: _motherNameController.text.trim(),
                fatherFirstName: _fatherNameController.text.trim(),
              ),
            );
      } else {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModelEditScaffold(
      title: "Family Information",
      onSubmitPress: _onSubmitTap,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...widgetInserter(
              children: [
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

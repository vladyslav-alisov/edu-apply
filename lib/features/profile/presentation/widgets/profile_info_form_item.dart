import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';

class ProfileInfoFormTextItem extends StatelessWidget {
  const ProfileInfoFormTextItem({
    super.key,
    required String title,
    dynamic data,
  })  : _data = data,
        _title = title;

  final String _title;
  final dynamic _data;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: textTheme.bodyMedium,
        ),
        Text(
          _data != null && _data.toString().isNotEmpty
              ? _data.toString()
              : "--",
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}

class ProfileInfoFormFileItem extends StatelessWidget {
  const ProfileInfoFormFileItem({
    super.key,
    required String title,
    AdditionalDocument? file,
  })  : _file = file,
        _title = title;

  final String _title;
  final AdditionalDocument? _file;

  String get _fileName {
    if (_file == null) return "--";
    String fileName = _file.file?.url.fileName ?? "File";
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String fileName = _fileName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: textTheme.bodyMedium,
        ),
        Text(
          fileName,
          style: textTheme.labelSmall?.copyWith(
            decoration: fileName != "--" ? TextDecoration.underline : null,
          ),
        ),
      ],
    );
  }
}

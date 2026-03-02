import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:uuid/uuid.dart';

class StyledFilePicker extends StatefulWidget {
  const StyledFilePicker({
    super.key,
    String? initFileUrl,
    required ValueChanged<File> onFilePicked,
    required VoidCallback onFileDeleted,
    required ValueChanged<File?> onFileInitialized,
  })  : _initFile = initFileUrl,
        _onFileDeleted = onFileDeleted,
        _onFilePicked = onFilePicked,
        _onFileInitialized = onFileInitialized;

  final String? _initFile;
  final ValueChanged<File> _onFilePicked;
  final VoidCallback _onFileDeleted;
  final ValueChanged<File?> _onFileInitialized;

  @override
  State<StyledFilePicker> createState() => _StyledFilePickerState();
}

class _StyledFilePickerState extends State<StyledFilePicker> {
  bool _isLoading = false;
  File? _currentFile;

  late final Uuid _uuid;

  @override
  void initState() {
    super.initState();
    _uuid = Uuid();
    String? fileUrl = widget._initFile;
    if (fileUrl != null) {
      _downloadFile(fileUrl);
    } else {
      widget._onFileInitialized(null);
    }
  }

  Future<void> _downloadFile(String initFilePath) async {
    try {
      _isLoading = true;

      String fileName = initFilePath.fileName;
      Directory directory = await getTemporaryDirectory();
      String directoryPath = "${directory.path}/${_uuid.v1()}/$fileName";

      _currentFile = File(directoryPath);
      setState(() => _isLoading = false);
      widget._onFileInitialized(_currentFile);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) showSnackBar(context, "Failed to load file");
    }
  }

  Future<void> _pickNewFile() async {
    try {
      setState(() => _isLoading = true);
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        widget._onFilePicked(file);
        _currentFile = file;
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) showSnackBar(context, "Failed to pick file");
    }
  }

  Future<void> _onDeleteFile() async {
    widget._onFileDeleted();
    setState(() => _currentFile = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LinearProgressIndicator();
    } else {
      if (_currentFile != null) {
        return FileDisplayWidget(
          file: _currentFile!,
          onDeleteFilePress: _onDeleteFile,
        );
      } else {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _pickNewFile,
            icon: Icon(Icons.add),
            label: Text("Add file"),
          ),
        );
      }
    }
  }
}

class FileDisplayWidget extends StatelessWidget {
  const FileDisplayWidget({
    super.key,
    required File file,
    required VoidCallback onDeleteFilePress,
  })  : _file = file,
        _onDeleteFilePress = onDeleteFilePress;

  final File _file;
  final VoidCallback _onDeleteFilePress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              Icon(Icons.file_copy),
              Gap(8),
              Flexible(
                child: Text(
                  _file.path.fileName,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _onDeleteFilePress,
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }
}

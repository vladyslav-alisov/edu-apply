import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/utils/file_utils.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/profile/presentation/widgets/profile_info_form_item.dart';

class AdditionalDocumentListTile extends StatefulWidget {
  const AdditionalDocumentListTile({
    super.key,
    required this.additionalDocument,
    required this.onDeletePress,
  });

  final AdditionalDocument additionalDocument;
  final ValueChanged<AdditionalDocument> onDeletePress;

  @override
  State<AdditionalDocumentListTile> createState() =>
      _AdditionalDocumentListTileState();
}

class _AdditionalDocumentListTileState
    extends State<AdditionalDocumentListTile> {
  bool _isSharing = false;

  Future<void> _onShareFilePress() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      String? fileUrl = widget.additionalDocument.file?.url;
      if (fileUrl == null) {
        showSnackBar(context, "Failed to download file");
        return;
      }
      File file = await downloadFile(fileUrl);
      XFile xFile = XFile(file.path);
      await Share.shareXFiles([xFile]);
    } finally {
      setState(() => _isSharing = false);
    }
  }

  Future<void> _onDeleteFilePress() async {
    if (_isSharing) return;
    widget.onDeletePress(widget.additionalDocument);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: ProfileInfoFormFileItem(
        title: "${widget.additionalDocument.name}",
        file: widget.additionalDocument,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _onShareFilePress,
            icon: _isSharing
                ? StyledLoadingIndicator()
                : Icon(
                    Icons.download_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
          IconButton(
            onPressed: _onDeleteFilePress,
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
          )
        ],
      ),
    );
  }
}

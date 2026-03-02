import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/utils/file_utils.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';

class StyledDownloadIcon extends StatefulWidget {
  const StyledDownloadIcon({
    super.key,
    required this.fileUrl,
    required this.onIsDownloadingStatusChange,
    this.icon,
  });

  final String? fileUrl;
  final ValueChanged<bool> onIsDownloadingStatusChange;
  final Icon? icon;

  @override
  State<StyledDownloadIcon> createState() => _StyledDownloadIconState();
}

class _StyledDownloadIconState extends State<StyledDownloadIcon> {
  bool _isSharing = false;

  Future<void> _onShareFilePress() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    widget.onIsDownloadingStatusChange(true);
    try {
      String? fileUrl = widget.fileUrl;
      if (fileUrl == null) {
        showSnackBar(context, "Failed to download file");
        return;
      }
      File file = await downloadFile(fileUrl);
      XFile xFile = XFile(file.path);
      await Share.shareXFiles([xFile]);
    } finally {
      setState(() => _isSharing = false);
      widget.onIsDownloadingStatusChange(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onShareFilePress,
      child: _isSharing
          ? StyledLoadingIndicator()
          : widget.icon ??
              Icon(
                Icons.download_outlined,
                size: 24,
                color: Theme.of(context).primaryColor,
              ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StyledOptionDialog extends StatelessWidget {
  const StyledOptionDialog({
    super.key,
    this.title,
    required this.content,
    this.confirmLabel,
    this.cancelLabel,
  });

  final String? title;
  final String content;
  final String? confirmLabel;
  final String? cancelLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? 'Confirm action',
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            cancelLabel ?? "Cancel",
          ),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            confirmLabel ?? "Confirm",
          ),
        ),
      ],
    );
  }
}

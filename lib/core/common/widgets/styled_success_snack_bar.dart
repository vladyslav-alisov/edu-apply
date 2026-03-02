import 'package:flutter/material.dart';

class StyledSuccessSnackBarContent extends StatelessWidget {
  const StyledSuccessSnackBarContent({
    super.key,
    required String content,
  }) : _content = content;

  final String _content;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF56638F),
          ),
          const SizedBox(width: 14),
          Text(_content),
        ],
      ),
    );
  }
}

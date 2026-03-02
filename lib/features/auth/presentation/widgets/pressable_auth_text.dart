import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PressableAuthText extends StatelessWidget {
  const PressableAuthText({
    super.key,
    required String text,
    required String pressableText,
    required VoidCallback onTextPress,
  })  : _text = text,
        _pressableText = pressableText,
        _onTextPress = onTextPress;

  final String _text;
  final String _pressableText;
  final VoidCallback _onTextPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Gap(4),
        GestureDetector(
          onTap: _onTextPress,
          child: Text(
            _pressableText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

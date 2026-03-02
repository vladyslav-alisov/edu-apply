import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required String text,
    required IconData icon,
  })  : _text = text,
        _icon = icon;

  final String? _text;
  final IconData? _icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_icon != null) ...[
          Icon(
            _icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          Gap(3),
        ],
        Text(
          _text ?? "--",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

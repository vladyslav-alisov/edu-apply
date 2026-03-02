import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LabeledWidget extends StatelessWidget {
  const LabeledWidget({
    super.key,
    required String label,
    required Widget child,
  })  : _label = label,
        _child = child;

  final String _label;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(12),
        _child,
      ],
    );
  }
}

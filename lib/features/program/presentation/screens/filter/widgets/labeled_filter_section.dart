import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LabeledFilterSection extends StatelessWidget {
  const LabeledFilterSection({
    super.key,
    required Widget child,
    required this.title,
  }) : _child = child;

  final String title;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Gap(12),
        _child,
      ],
    );
  }
}

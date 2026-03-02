import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthTitleText extends StatelessWidget {
  const AuthTitleText({
    super.key,
    required String title,
    required String description,
  })  : _title = title,
        _description = description;

  final String _title;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const Gap(12),
        Text(
          _description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

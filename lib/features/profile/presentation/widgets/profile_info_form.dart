import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';

class ProfileInfoFormTemplate extends StatelessWidget {
  const ProfileInfoFormTemplate({
    super.key,
    required String title,
    required List<Widget> children,
    Widget? rightTitle,
  })  : _title = title,
        _children = children,
        _rightTitle = rightTitle;

  final String _title;
  final Widget? _rightTitle;
  final List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (_rightTitle != null) _rightTitle,
          ],
        ),
        Gap(8),
        StyledContainer(
          borderColor: Theme.of(context).colorScheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widgetInserter(
                children: _children,
                separator: Gap(16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

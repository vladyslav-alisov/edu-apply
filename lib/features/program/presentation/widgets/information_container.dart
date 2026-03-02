import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';

class InformationContainer extends StatelessWidget {
  const InformationContainer({
    super.key,
    required String title,
    required List<Widget> children,
    Widget? titleTrailing,
  })  : _children = children,
        _titleTrailing = titleTrailing,
        _title = title;

  final String _title;
  final List<Widget> _children;
  final Widget? _titleTrailing;

  @override
  Widget build(BuildContext context) {
    return StyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (_titleTrailing != null) _titleTrailing,
            ],
          ),
          Gap(
            15,
          ),
          ..._children,
        ],
      ),
    );
  }
}

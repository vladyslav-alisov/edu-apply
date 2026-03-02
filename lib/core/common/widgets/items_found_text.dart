import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/icon_container.dart';

class ItemsFoundText extends StatelessWidget {
  const ItemsFoundText({
    super.key,
    required String title,
    required int totalElements,
    IconData? iconData,
  })  : _totalElements = totalElements,
        _title = title,
        _iconData = iconData;

  final String _title;
  final int _totalElements;
  final IconData? _iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_iconData != null) ...[
          Icon(
            _iconData,
            color: Theme.of(context).primaryColor,
          ),
          Gap(4),
        ],
        Text(_title),
        Gap(4),
        IconContainer(
          child: Text(
            "$_totalElements",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

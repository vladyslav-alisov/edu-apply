import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const double kDividerHeight = 24.0;

class DetailsInfoItem extends StatelessWidget {
  const DetailsInfoItem({
    super.key,
    required String title,
    required dynamic data,
    IconData? iconData,
    Color? iconColor,
    TextStyle? dataTextStyle,
  })  : _iconData = iconData,
        _title = title,
        _data = data,
        _iconColor = iconColor,
        _dataTextStyle = dataTextStyle;

  final String _title;
  final IconData? _iconData;
  final Color? _iconColor;
  final dynamic _data;
  final TextStyle? _dataTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (_iconData != null) ...[
              Icon(
                _iconData,
                color: _iconColor ?? Theme.of(context).colorScheme.primary,
                size: 16,
              ),
              Gap(4),
            ],
            Text(
              _title,
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Flexible(
          child: Text(
            _data != null && _data.toString().isNotEmpty ? _data.toString() : "--",
            style: _dataTextStyle ?? Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

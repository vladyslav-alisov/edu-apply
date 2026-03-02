import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';

class StepInformationWidget extends StatelessWidget {
  const StepInformationWidget({
    super.key,
    required String title,
    required DateTime date,
    required void Function() onStepPress,
    required bool isUserAction,
  })  : _onStepPress = onStepPress,
        _date = date,
        _title = title,
        _isRight = isUserAction;

  final String _title;
  final DateTime _date;
  final VoidCallback _onStepPress;
  final bool _isRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          _isRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          _title,
          style: Theme.of(context).textTheme.titleLarge,
          textDirection: _isRight ? TextDirection.ltr : TextDirection.rtl,
        ),
        Text(
          _date.appLogDate,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Color(
                  0xFF6E6E6E,
                ),
              ),
          textDirection: _isRight ? TextDirection.ltr : TextDirection.rtl,
        ),
        Text(
          _date.appLogTime,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Color(
                  0xFF6E6E6E,
                ),
              ),
          textDirection: _isRight ? TextDirection.ltr : TextDirection.rtl,
        ),
        GestureDetector(
          onTap: _onStepPress,
          child: Text(
            "Click for details",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  decoration: TextDecoration.underline,
                ),
            textDirection: _isRight ? TextDirection.ltr : TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}

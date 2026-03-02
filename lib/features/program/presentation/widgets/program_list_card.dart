import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/currency.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/features/program/presentation/widgets/icon_text.dart';

class ProgramListCard extends StatelessWidget {
  const ProgramListCard({
    super.key,
    required String language,
    required ModeOfStudy modeOfStudy,
    required CampusType campusType,
    required DateTime programStartMonth,
    required Currency currency,
    required double? tuitionFee,
    void Function()? onApplyPressed,
  })  : _onApplyPressed = onApplyPressed,
        _language = language,
        _modeOfStudy = modeOfStudy,
        _campusType = campusType,
        _programStartMonth = programStartMonth,
        _currency = currency,
        _tuitionFee = tuitionFee;

  final String _language;
  final ModeOfStudy _modeOfStudy;
  final CampusType _campusType;
  final DateTime _programStartMonth;
  final Currency _currency;
  final double? _tuitionFee;

  final VoidCallback? _onApplyPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(
                  text: _language.capitalize,
                  icon: Icons.language_outlined,
                ),
                Gap(4),
                IconText(
                  text: _modeOfStudy.getTitle(context),
                  icon: Icons.watch_later_outlined,
                ),
                Gap(4),
                IconText(
                  text: _campusType.getTitle(context),
                  icon: Icons.location_on_outlined,
                ),
                Gap(4),
                Text(
                  "Season: ${_programStartMonth.appSeasonFormat}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Gap(8),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_currency.symbol}${(_tuitionFee ?? 0).toInt()}",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  "Annual price",
                  style: Theme.of(context).textTheme.labelSmall,
                  textDirection: TextDirection.rtl,
                ),
                Gap(5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onApplyPressed,
                    child: Text("Apply"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

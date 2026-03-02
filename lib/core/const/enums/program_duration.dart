import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum ProgramDuration implements Translatable {
  halfAYear(6),
  oneYear(12),
  oneAndAHalfYears(18),
  twoYears(24),
  threeYears(36),
  fourYears(48),
  fiveYears(60),
  sixYears(72);

  const ProgramDuration(this.durationInMonths);

  final int durationInMonths;

  @override
  String getTitle(BuildContext context) {
    if (durationInMonths == 6) {
      return "6 months";
    } else if (durationInMonths == 12) {
      return "1 year";
    } else if (durationInMonths == 18) {
      double years = (durationInMonths / 12);
      return "$years years";
    } else {
      int years = (durationInMonths ~/ 12);
      return "$years years";
    }
  }
}

import 'package:flutter/material.dart';

enum ProgramSortType {
  suggested("SUGGESTED"),
  lowestTuition("LOWEST_TUITION"),
  highestTuition("HIGHEST_TUITION"),
  deadlineClosing("DEADLINE_CLOSING");

  final String json;

  const ProgramSortType(this.json);

  String getTitle(BuildContext context) => switch (this) {
        ProgramSortType.lowestTuition => "Lowest Tuition",
        ProgramSortType.highestTuition => "Highest Tuition",
        ProgramSortType.deadlineClosing => "Closing Soonest",
        ProgramSortType.suggested => "Suggested",
      };
}

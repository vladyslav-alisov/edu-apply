import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum ModeOfStudy implements Translatable {
  fullTime("FULL_TIME"),
  partTime("PART_TIME"),
  online("ONLINE");

  final String json;

  const ModeOfStudy(this.json);

  @override
  String getTitle(BuildContext context) => switch (this) {
        ModeOfStudy.fullTime => "Full-Time",
        ModeOfStudy.partTime => "Part-Time",
        ModeOfStudy.online => "Online",
      };
}

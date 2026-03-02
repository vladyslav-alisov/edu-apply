import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum CampusType implements Translatable {
  onCampus("ON_CAMPUS"),
  offCampus("OFF_CAMPUS");

  const CampusType(this.json);

  final String json;

  @override
  String getTitle(BuildContext context) => switch (this) {
        CampusType.onCampus => "On Site",
        CampusType.offCampus => "Remote",
      };

  static CampusType? fromString(String? value) {
    if (value == null) return null;

    return CampusType.values
        .firstWhereOrNull((e) => e.json == value.toUpperCase());
  }
}

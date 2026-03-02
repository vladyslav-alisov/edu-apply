import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum UniversityType implements Translatable {
  state("STATE"),
  private("PRIVATE");

  final String json;

  const UniversityType(this.json);

  @override
  String getTitle(BuildContext context) => switch (this) {
        UniversityType.state => "State",
        UniversityType.private => "Private",
      };

  static UniversityType? fromString(String? value) {
    if (value == null) return null;

    return UniversityType.values
        .firstWhereOrNull((e) => e.json == value.toUpperCase());
  }
}

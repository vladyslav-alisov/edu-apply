import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum DegreeType implements Translatable {
  associateDegree("ASSOCIATE_DEGREE"),
  bachelorDegree("BACHELOR_DEGREE"),
  masterNonThesis("MASTER_NON_THESIS"),
  masterWithThesis("MASTER_WITH_THESIS"),
  phdDegree("PHD_DEGREE");

  const DegreeType(this.json);

  final String json;

  @override
  String getTitle(BuildContext context) => switch (this) {
        DegreeType.associateDegree => "Associate Degree",
        DegreeType.bachelorDegree => "Bachelor's Degree",
        DegreeType.masterNonThesis => "Master's Degree (Non-Thesis)",
        DegreeType.masterWithThesis => "Master's Degree (With Thesis)",
        DegreeType.phdDegree => "PhD Degree",
      };

  static DegreeType? fromString(String? value) {
    if (value == null) return null;

    return DegreeType.values
        .firstWhereOrNull((e) => e.json == value.toUpperCase());
  }
}

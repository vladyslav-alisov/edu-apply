import 'package:collection/collection.dart';
import 'package:edu_apply/core/const/enums/season.dart';
import 'package:edu_apply/features/program/domain/entities/program_period.dart';

class ProgramPeriodModel extends ProgramPeriod {
  ProgramPeriodModel({
    required super.id,
    required super.label,
    required super.year,
    required super.season,
  });

  factory ProgramPeriodModel.fromJson(Map<String, dynamic> json) =>
      ProgramPeriodModel(
        id: json["id"] ?? "",
        label: json["label"] ?? "",
        year: json["year"] ?? "",
        season: Season.values
            .firstWhereOrNull((element) => element.json == json["season"]),
      );
}

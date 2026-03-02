import 'package:edu_apply/features/program/data/models/program_period_model.dart';
import 'package:edu_apply/features/program/domain/entities/program_application_date.dart';

class ProgramApplicationDateModel extends ProgramApplicationDate {
  ProgramApplicationDateModel({
    required super.id,
    required super.quotaIsFull,
    required super.programId,
    required super.startDate,
    required super.endDate,
    required super.period,
  });

  factory ProgramApplicationDateModel.fromJson(Map<String, dynamic> json) =>
      ProgramApplicationDateModel(
        id: json["id"],
        quotaIsFull: json["quotaIsFull"] ?? true,
        programId: json["programId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        period: ProgramPeriodModel.fromJson(json["period"]),
      );
}

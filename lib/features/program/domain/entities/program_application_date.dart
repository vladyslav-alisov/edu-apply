import 'package:edu_apply/features/program/domain/entities/program_period.dart';

class ProgramApplicationDate {
  String id;
  bool quotaIsFull;
  String programId;
  DateTime startDate;
  DateTime endDate;
  ProgramPeriod period;

  ProgramApplicationDate({
    required this.id,
    required this.quotaIsFull,
    required this.programId,
    required this.startDate,
    required this.endDate,
    required this.period,
  });
}

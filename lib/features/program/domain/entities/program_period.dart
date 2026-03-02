import 'package:edu_apply/core/const/enums/season.dart';

class ProgramPeriod {
  String id;
  String label;
  String year;
  Season? season;

  ProgramPeriod({
    required this.id,
    required this.label,
    required this.year,
    required this.season,
  });
}

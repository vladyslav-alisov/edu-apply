import 'package:edu_apply/core/common/entities/additional_document.dart';

class LanguageProficiency {
  String id;
  String? studentId;
  String? language;
  DateTime? dateOfExam;
  String? grade;
  AdditionalDocument? certificate;

  LanguageProficiency({
    required this.id,
    required this.studentId,
    required this.language,
    required this.dateOfExam,
    required this.grade,
    required this.certificate,
  });
}

import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/features/profile/domain/entities/language_proficiency.dart';

class LanguageProficiencyModel extends LanguageProficiency {
  LanguageProficiencyModel({
    required super.id,
    required super.studentId,
    required super.language,
    required super.dateOfExam,
    required super.grade,
    required super.certificate,
  });

  factory LanguageProficiencyModel.fromJson(Map<String, dynamic> json) =>
      LanguageProficiencyModel(
        id: json["id"],
        studentId: json["studentId"],
        language: json["language"],
        dateOfExam: json["dateOfExam"] != null
            ? DateTime.tryParse(json["dateOfExam"])
            : json["dateOfExam"],
        grade: json["grade"],
        certificate: json["certificate"] == null
            ? null
            : AdditionalDocumentModel.fromJson(json["certificate"]),
      );
}

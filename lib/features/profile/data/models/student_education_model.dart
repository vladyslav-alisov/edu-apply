import 'package:collection/collection.dart';
import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/features/profile/domain/entities/student_education.dart';

class StudentEducationModel extends StudentEducation {
  StudentEducationModel({
    required super.id,
    required super.studentId,
    required super.nameOfSchool,
    required super.countryCode,
    required super.graduationYear,
    required super.degreeName,
    required super.cgpa,
    required super.transcript,
    required super.diploma,
  });

  factory StudentEducationModel.fromJson(Map<String, dynamic> json) =>
      StudentEducationModel(
        id: json["id"],
        studentId: json["studentId"],
        nameOfSchool: json["nameOfSchool"],
        countryCode: AvailableCountryCode.values.firstWhereOrNull(
          (element) => element.json == json["countryCode"],
        ),
        graduationYear: json["graduationYear"],
        degreeName: json["degreeName"],
        cgpa: json["cgpa"],
        transcript: json["transcript"] == null
            ? null
            : AdditionalDocumentModel.fromJson(json["transcript"]),
        diploma: json["diploma"] == null
            ? null
            : AdditionalDocumentModel.fromJson(json["diploma"]),
      );
}

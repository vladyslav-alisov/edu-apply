import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';

class StudentEducation {
  String id;
  String? studentId;
  String? nameOfSchool;
  AvailableCountryCode? countryCode;
  String? graduationYear;
  String? degreeName;
  String? cgpa;
  AdditionalDocument? transcript;
  AdditionalDocument? diploma;

  StudentEducation({
    required this.id,
    required this.studentId,
    required this.nameOfSchool,
    required this.countryCode,
    required this.graduationYear,
    required this.degreeName,
    required this.cgpa,
    required this.transcript,
    required this.diploma,
  });
}

import 'package:edu_apply/core/common/entities/additional_document.dart';

class PassportInformation {
  String id;
  String? studentId;
  DateTime? dateOfIssue;
  DateTime? dateOfExpire;
  String? passportNumber;
  bool? needVisa;
  AdditionalDocument? file;

  PassportInformation({
    required this.id,
    required this.studentId,
    required this.dateOfIssue,
    required this.dateOfExpire,
    required this.passportNumber,
    required this.needVisa,
    required this.file,
  });
}

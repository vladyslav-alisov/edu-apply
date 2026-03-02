import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/features/profile/domain/entities/passport_information.dart';

class PassportInformationModel extends PassportInformation {
  PassportInformationModel({
    required super.id,
    required super.studentId,
    required super.dateOfIssue,
    required super.dateOfExpire,
    required super.passportNumber,
    required super.needVisa,
    required super.file,
  });

  factory PassportInformationModel.fromJson(Map<String, dynamic> json) =>
      PassportInformationModel(
        id: json["id"],
        studentId: json["studentId"],
        dateOfIssue: json["dateOfIssue"] != null
            ? DateTime.tryParse(json["dateOfIssue"])
            : json["dateOfIssue"],
        dateOfExpire: json["dateOfExpire"] != null
            ? DateTime.tryParse(json["dateOfExpire"])
            : json["dateOfExpire"],
        passportNumber: json["passportNumber"],
        needVisa: json["needVisa"],
        file: json["file"] == null
            ? null
            : AdditionalDocumentModel.fromJson(json["file"]),
      );
}

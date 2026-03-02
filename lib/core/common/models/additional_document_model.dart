import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';

class AdditionalDocumentModel extends AdditionalDocument {
  AdditionalDocumentModel({
    required super.id,
    required super.studentId,
    required super.file,
    required super.name,
    required super.grade,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdditionalDocumentModel.fromJson(Map<String, dynamic> json) =>
      AdditionalDocumentModel(
        id: json["id"],
        studentId: json["studentId"],
        file: json["file"] == null
            ? null
            : AttachmentModel.fromJson(json["file"]),
        name: json["name"],
        grade: json["grade"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}

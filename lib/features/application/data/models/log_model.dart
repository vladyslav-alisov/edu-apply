import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/const/enums/application_status.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';

class LogModel extends Log {
  LogModel({
    required super.id,
    required super.applicationId,
    required super.createdBy,
    required super.title,
    required super.message,
    required super.creatorName,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required super.files,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        applicationId: json["applicationId"],
        createdBy: json["createdBy"],
        title: json["title"] ?? "",
        message: json["message"] ?? "",
        creatorName: json["creatorName"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        status: ApplicationStatus.fromString(json["status"]) ??
            ApplicationStatus.newApplication,
        files: json["files"] != null
            ? List<AdditionalDocumentModel>.from(
                json["files"].map(
                  (x) => AdditionalDocumentModel.fromJson(x),
                ),
              )
            : [],
      );
}

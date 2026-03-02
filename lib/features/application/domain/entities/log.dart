import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/const/enums/application_status.dart';

class Log {
  String id;
  String applicationId;
  String createdBy;
  String title;
  String message;
  String creatorName;
  DateTime createdAt;
  DateTime updatedAt;
  ApplicationStatus status;
  List<AdditionalDocument> files;

  Log({
    required this.id,
    required this.applicationId,
    required this.createdBy,
    required this.title,
    required this.message,
    required this.creatorName,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.files,
  });
}

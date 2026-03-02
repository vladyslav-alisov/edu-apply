import 'package:edu_apply/core/common/entities/attachment.dart';

class AdditionalDocument {
  String id;
  String? studentId;
  Attachment? file;
  String? name;
  String? grade;
  DateTime? createdAt;
  DateTime? updatedAt;

  AdditionalDocument({
    required this.id,
    required this.studentId,
    required this.file,
    required this.name,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
  });
}

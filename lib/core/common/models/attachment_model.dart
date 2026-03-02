import 'package:edu_apply/core/common/entities/attachment.dart';

class AttachmentModel extends Attachment {
  AttachmentModel({
    required super.id,
    required super.url,
    required super.fileType,
    required super.size,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        id: json["id"],
        url: json["url"],
        fileType: json["fileType"],
        size: json["size"],
      );
}

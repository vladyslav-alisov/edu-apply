import 'package:edu_apply/features/application/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    required super.createdBy,
    required super.text,
    required super.creatorName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"] ?? "",
        createdBy: json["createdBy"] ?? "",
        text: json["text"] ?? "",
        creatorName: json["creatorName"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class Comment {
  String id;
  String createdBy;
  String text;
  String creatorName;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.id,
    required this.createdBy,
    required this.text,
    required this.creatorName,
    required this.createdAt,
    required this.updatedAt,
  });
}

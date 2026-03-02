import 'package:edu_apply/features/application/data/models/comment_model.dart';

final Map<String, List<CommentModel>> dummyComments = {
  'app-001': [
    CommentModel(
      id: 'comment-001',
      createdBy: 'counsellor-001',
      text:
          'Your application has been received. We are currently reviewing your documents.',
      creatorName: 'Mike Johnson',
      createdAt: DateTime(2026, 1, 16),
      updatedAt: DateTime(2026, 1, 16),
    ),
    CommentModel(
      id: 'comment-002',
      createdBy: 'student-001',
      text: 'Thank you! Please let me know if you need anything else.',
      creatorName: 'John Doe',
      createdAt: DateTime(2026, 1, 17),
      updatedAt: DateTime(2026, 1, 17),
    ),
  ],
  'app-002': [
    CommentModel(
      id: 'comment-003',
      createdBy: 'counsellor-002',
      text: 'Your application has been forwarded to the University of Oxford.',
      creatorName: 'Emily Brown',
      createdAt: DateTime(2026, 2, 5),
      updatedAt: DateTime(2026, 2, 5),
    ),
  ],
  'app-003': [
    CommentModel(
      id: 'comment-004',
      createdBy: 'counsellor-001',
      text: 'Congratulations! You have received an admission offer from TUM.',
      creatorName: 'Mike Johnson',
      createdAt: DateTime(2026, 2, 15),
      updatedAt: DateTime(2026, 2, 15),
    ),
    CommentModel(
      id: 'comment-005',
      createdBy: 'student-001',
      text: 'That is great news! What are the next steps?',
      creatorName: 'John Doe',
      createdAt: DateTime(2026, 2, 15),
      updatedAt: DateTime(2026, 2, 15),
    ),
    CommentModel(
      id: 'comment-006',
      createdBy: 'counsellor-001',
      text: 'Please proceed with the deposit payment to secure your spot.',
      creatorName: 'Mike Johnson',
      createdAt: DateTime(2026, 2, 16),
      updatedAt: DateTime(2026, 2, 16),
    ),
  ],
  'app-004': [],
  'app-005': [
    CommentModel(
      id: 'comment-007',
      createdBy: 'counsellor-002',
      text:
          'We noticed some documents are missing. Please upload your transcript.',
      creatorName: 'Emily Brown',
      createdAt: DateTime(2026, 2, 10),
      updatedAt: DateTime(2026, 2, 10),
    ),
  ],
};

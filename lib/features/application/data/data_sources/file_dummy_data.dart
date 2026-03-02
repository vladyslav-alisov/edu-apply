import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';

final Map<String, List<AdditionalDocumentModel>> dummyApplicationFiles = {
  'app-001': [
    AdditionalDocumentModel(
      id: 'file-001',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-001',
        url: 'https://picsum.photos/seed/appfile1/200',
        fileType: 'application/pdf',
        size: 3072,
      ),
      name: 'Transcript',
      grade: null,
      createdAt: DateTime(2026, 1, 15),
      updatedAt: DateTime(2026, 1, 15),
    ),
    AdditionalDocumentModel(
      id: 'file-002',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-002',
        url: 'https://picsum.photos/seed/appfile2/200',
        fileType: 'application/pdf',
        size: 2048,
      ),
      name: 'Motivation Letter',
      grade: null,
      createdAt: DateTime(2026, 1, 16),
      updatedAt: DateTime(2026, 1, 16),
    ),
  ],
  'app-002': [
    AdditionalDocumentModel(
      id: 'file-003',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-003',
        url: 'https://picsum.photos/seed/appfile3/200',
        fileType: 'application/pdf',
        size: 4096,
      ),
      name: 'Research Proposal',
      grade: null,
      createdAt: DateTime(2026, 2, 2),
      updatedAt: DateTime(2026, 2, 2),
    ),
  ],
  'app-003': [
    AdditionalDocumentModel(
      id: 'file-004',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-004',
        url: 'https://picsum.photos/seed/appfile4/200',
        fileType: 'application/pdf',
        size: 1024,
      ),
      name: 'Recommendation Letter',
      grade: null,
      createdAt: DateTime(2025, 11, 12),
      updatedAt: DateTime(2025, 11, 12),
    ),
    AdditionalDocumentModel(
      id: 'file-005',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-005',
        url: 'https://picsum.photos/seed/appfile5/200',
        fileType: 'application/pdf',
        size: 2048,
      ),
      name: 'CV',
      grade: null,
      createdAt: DateTime(2025, 11, 12),
      updatedAt: DateTime(2025, 11, 12),
    ),
  ],
  'app-004': [],
  'app-005': [],
};

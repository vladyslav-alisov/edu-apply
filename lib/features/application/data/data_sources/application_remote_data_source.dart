import 'dart:io';

import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/common/models/paginated_response_model.dart';
import 'package:edu_apply/features/application/data/models/application_model.dart';
import 'package:edu_apply/features/application/data/models/comment_model.dart';
import 'package:edu_apply/features/application/data/models/log_model.dart';

abstract interface class ApplicationRemoteDataSource {
  Future<PaginatedResponseModel<ApplicationModel>> getApplications({
    int page = 0,
    int size = 10,
  });

  Future<ApplicationModel> createApplication({
    required String universityId,
    required String universityProgramId,
    required double tuitionFee,
    String? periodId,
    String? universityApplyCode,
    String? studentNumber,
    String? id,
  });

  Future<String> deleteApplication({
    required String applicationId,
  });

  Future<PaginatedResponseModel<AdditionalDocumentModel>> getFiles({
    required String applicationId,
    int page = 0,
    int size = 10,
  });

  Future<AdditionalDocumentModel> addFile({
    required String applicationId,
    required File file,
    required String name,
  });

  Future<List<CommentModel>> getComments({
    required String applicationId,
  });

  Future<CommentModel> createComment({
    required String applicationId,
    required String text,
  });

  Future<List<LogModel>> getLogs({
    required String applicationId,
  });
}

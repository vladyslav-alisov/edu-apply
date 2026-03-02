import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';

abstract interface class ApplicationRepository {
  Future<Either<Failure, PaginatedResponse<Application>>> getApplications({
    int page = 0,
    int size = 10,
  });

  Future<Either<Failure, Application>> createApplication({
    required String universityId,
    required String universityProgramId,
    required double tuitionFee,
    required String periodId,
    String? universityApplyCode,
    String? studentNumber,
    String? id,
  });

  Future<Either<Failure, String>> deleteApplication({
    required String applicationId,
  });

  Future<Either<Failure, PaginatedResponse<AdditionalDocument>>> getFiles({
    required String applicationId,
    int page = 0,
    int size = 10,
  });

  Future<Either<Failure, List<Comment>>> getComments({
    required String applicationId,
  });

  Future<Either<Failure, Comment>> createComment({
    required String applicationId,
    required String text,
  });

  Future<Either<Failure, AdditionalDocument>> addFile({
    required String applicationId,
    required String name,
    required File file,
  });

  Future<Either<Failure, List<Log>>> getLogs({
    required String applicationId,
  });
}

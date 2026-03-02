import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/error/exceptions.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/application/data/data_sources/application_remote_data_source.dart';
import 'package:edu_apply/features/application/data/models/application_model.dart';
import 'package:edu_apply/features/application/data/models/log_model.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource _applicationRemoteDataSource;

  ApplicationRepositoryImpl({
    required ApplicationRemoteDataSource applicationRemoteDataSource,
  }) : _applicationRemoteDataSource = applicationRemoteDataSource;

  @override
  Future<Either<Failure, Application>> createApplication({
    required String universityId,
    required String universityProgramId,
    required double tuitionFee,
    required String periodId,
    String? universityApplyCode,
    String? studentNumber,
    String? id,
  }) async {
    try {
      ApplicationModel result =
          await _applicationRemoteDataSource.createApplication(
        universityId: universityId,
        universityProgramId: universityProgramId,
        tuitionFee: tuitionFee,
        periodId: periodId,
        universityApplyCode: universityApplyCode,
        studentNumber: studentNumber,
        id: id,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteApplication({
    required String applicationId,
  }) async {
    try {
      String result = await _applicationRemoteDataSource.deleteApplication(
        applicationId: applicationId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<Application>>> getApplications({
    int page = 0,
    int size = 10,
  }) async {
    try {
      PaginatedResponse<Application> result =
          await _applicationRemoteDataSource.getApplications(
        page: page,
        size: size,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment({
    required String applicationId,
    required String text,
  }) async {
    try {
      Comment result = await _applicationRemoteDataSource.createComment(
        applicationId: applicationId,
        text: text,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComments({
    required String applicationId,
  }) async {
    try {
      List<Comment> result = await _applicationRemoteDataSource.getComments(
        applicationId: applicationId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<AdditionalDocument>>> getFiles({
    required String applicationId,
    int page = 0,
    int size = 10,
  }) async {
    try {
      PaginatedResponse<AdditionalDocument> result =
          await _applicationRemoteDataSource.getFiles(
        applicationId: applicationId,
        size: size,
        page: page,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Log>>> getLogs({
    required String applicationId,
  }) async {
    try {
      List<LogModel> result = await _applicationRemoteDataSource.getLogs(
        applicationId: applicationId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, AdditionalDocument>> addFile({
    required String applicationId,
    required String name,
    required File file,
  }) async {
    try {
      AdditionalDocument result = await _applicationRemoteDataSource.addFile(
        applicationId: applicationId,
        file: file,
        name: name,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

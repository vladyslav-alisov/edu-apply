import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class GetCommentsParams {
  final String applicationId;

  GetCommentsParams({
    required this.applicationId,
  });
}

class GetComments implements UseCase<List<Comment>, GetCommentsParams> {
  final ApplicationRepository _applicationRepository;

  GetComments({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, List<Comment>>> call(
    GetCommentsParams params,
  ) async {
    return await _applicationRepository.getComments(
      applicationId: params.applicationId,
    );
  }
}

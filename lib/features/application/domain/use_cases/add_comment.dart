import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class AddCommentParams {
  final String text;
  final String applicationId;

  AddCommentParams({
    required this.text,
    required this.applicationId,
  });
}

class AddComment implements UseCase<Comment, AddCommentParams> {
  final ApplicationRepository _applicationRepository;

  AddComment({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, Comment>> call(
    AddCommentParams params,
  ) async {
    return await _applicationRepository.createComment(
      text: params.text,
      applicationId: params.applicationId,
    );
  }
}

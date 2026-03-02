import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class DeleteApplicationParams {
  final String applicationId;

  DeleteApplicationParams({
    required this.applicationId,
  });
}

class DeleteApplication implements UseCase<String, DeleteApplicationParams> {
  final ApplicationRepository _applicationRepository;

  DeleteApplication({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, String>> call(
    DeleteApplicationParams params,
  ) async {
    return await _applicationRepository.deleteApplication(
      applicationId: params.applicationId,
    );
  }
}

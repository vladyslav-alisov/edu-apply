import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class GetLogsParams {
  final String applicationId;

  GetLogsParams({
    required this.applicationId,
  });
}

class GetLogs implements UseCase<List<Log>, GetLogsParams> {
  final ApplicationRepository _applicationRepository;

  GetLogs({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, List<Log>>> call(
    GetLogsParams params,
  ) async {
    return await _applicationRepository.getLogs(
      applicationId: params.applicationId,
    );
  }
}

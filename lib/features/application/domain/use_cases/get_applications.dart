import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class GetApplicationsParams {
  final int size;
  final int page;

  GetApplicationsParams({
    this.size = 10,
    this.page = 0,
  });
}

class GetApplications
    implements UseCase<PaginatedResponse<Application>, GetApplicationsParams> {
  final ApplicationRepository _applicationRepository;

  GetApplications({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, PaginatedResponse<Application>>> call(
    GetApplicationsParams params,
  ) async {
    return await _applicationRepository.getApplications(
      size: params.size,
      page: params.page,
    );
  }
}

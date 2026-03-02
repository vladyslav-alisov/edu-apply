import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class GetFilesParams {
  final String applicationId;
  final int page;
  final int size;

  GetFilesParams({
    required this.applicationId,
    this.page = 0,
    this.size = 10,
  });
}

class GetFiles
    implements UseCase<PaginatedResponse<AdditionalDocument>, GetFilesParams> {
  final ApplicationRepository _applicationRepository;

  GetFiles({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, PaginatedResponse<AdditionalDocument>>> call(
    GetFilesParams params,
  ) async {
    return await _applicationRepository.getFiles(
      applicationId: params.applicationId,
      page: params.page,
      size: params.size,
    );
  }
}

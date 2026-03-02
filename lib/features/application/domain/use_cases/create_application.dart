import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class CreateApplicationParams {
  final String universityId;
  final String universityProgramId;
  final double tuitionFee;
  final String periodId;
  final String? universityApplyCode;
  final String? studentNumber;
  final String? id;

  CreateApplicationParams({
    required this.universityId,
    required this.universityProgramId,
    required this.tuitionFee,
    required this.periodId,
    this.universityApplyCode,
    this.studentNumber,
    this.id,
  });
}

class CreateApplication
    implements UseCase<Application, CreateApplicationParams> {
  final ApplicationRepository _applicationRepository;

  CreateApplication({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, Application>> call(
    CreateApplicationParams params,
  ) async {
    return await _applicationRepository.createApplication(
      universityId: params.universityId,
      universityProgramId: params.universityProgramId,
      tuitionFee: params.tuitionFee,
      periodId: params.periodId,
      universityApplyCode: params.universityApplyCode,
      studentNumber: params.studentNumber,
      id: params.id,
    );
  }
}

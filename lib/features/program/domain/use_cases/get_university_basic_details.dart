import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';
import 'package:edu_apply/features/program/domain/repositories/program_repository.dart';

class GetUniversityBasicDetails
    implements UseCase<List<UniversityBasicDetails>, NoParams> {
  GetUniversityBasicDetails({
    required ProgramRepository programRepository,
  }) : _programRepository = programRepository;

  final ProgramRepository _programRepository;

  @override
  Future<Either<Failure, List<UniversityBasicDetails>>> call(
      NoParams params) async {
    return await _programRepository.getAvailableUniversityBasicDetails();
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/program/domain/repositories/program_repository.dart';

class GetCountries implements UseCase<List<AvailableCountryCode>, NoParams> {
  GetCountries({
    required ProgramRepository programRepository,
  }) : _programRepository = programRepository;

  final ProgramRepository _programRepository;

  @override
  Future<Either<Failure, List<AvailableCountryCode>>> call(
      NoParams params) async {
    return await _programRepository.getAvailableCountries();
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/const/enums/available_language.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/program_duration.dart';
import 'package:edu_apply/core/const/enums/program_sort_type.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/domain/repositories/program_repository.dart';

class GetProgramsParams {
  int? page = 0;
  int? size = 10;
  String? name;
  List<AvailableCountryCode>? countryCode;
  List<String>? city;
  List<String>? university;
  List<DegreeType>? degreeType;
  List<CampusType>? campusType;
  List<UniversityType>? universityType;
  List<ModeOfStudy>? modeOfStudy;
  List<AvailableLanguage>? language;
  double? maxFee;
  double? minFee;
  bool? isFull;
  String? deadline;
  List<ProgramDuration>? durationInMonths;
  String? faculty;
  ProgramSortType? sortType;

  GetProgramsParams({
    this.page,
    this.size,
    this.name = "",
    this.countryCode,
    this.city,
    this.university,
    this.degreeType,
    this.campusType,
    this.universityType,
    this.modeOfStudy,
    this.language,
    this.maxFee,
    this.minFee,
    this.isFull,
    this.deadline,
    this.durationInMonths,
    this.faculty,
    this.sortType,
  });
}

class GetPrograms
    implements UseCase<PaginatedResponse<Program>, GetProgramsParams> {
  GetPrograms({
    required ProgramRepository programRepository,
  }) : _programRepository = programRepository;

  final ProgramRepository _programRepository;

  @override
  Future<Either<Failure, PaginatedResponse<Program>>> call(
      GetProgramsParams params) async {
    return await _programRepository.getPrograms(
      page: params.page,
      size: params.size,
      name: params.name,
      countryCode: params.countryCode,
      city: params.city,
      university: params.university,
      degreeType: params.degreeType,
      campusType: params.campusType,
      universityType: params.universityType,
      modeOfStudy: params.modeOfStudy,
      language: params.language,
      maxFee: params.maxFee,
      minFee: params.minFee,
      isFull: params.isFull,
      deadline: params.deadline,
      durationInMonths: params.durationInMonths,
      faculty: params.faculty,
      sortType: params.sortType,
    );
  }
}

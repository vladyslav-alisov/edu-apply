import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/common/models/paginated_response_model.dart';
import 'package:edu_apply/core/const/enums/available_language.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/program_duration.dart';
import 'package:edu_apply/core/const/enums/program_sort_type.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/core/error/exceptions.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/program/data/data_sources/program_remote_data_source.dart';
import 'package:edu_apply/features/program/data/models/program_model.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';
import 'package:edu_apply/features/program/domain/repositories/program_repository.dart';

class ProgramRepositoryImpl implements ProgramRepository {
  final ProgramRemoteDataSource _programRemoteDataSource;

  ProgramRepositoryImpl({
    required ProgramRemoteDataSource programRemoteDataSource,
  }) : _programRemoteDataSource = programRemoteDataSource;

  @override
  Future<Either<Failure, PaginatedResponse<Program>>> getPrograms({
    int? page = 0,
    int? size = 10,
    String? name,
    List<AvailableCountryCode>? countryCode,
    List<String>? city,
    List<String>? university,
    List<DegreeType>? degreeType,
    List<CampusType>? campusType,
    List<UniversityType>? universityType,
    List<ModeOfStudy>? modeOfStudy,
    List<AvailableLanguage>? language,
    double? maxFee,
    double? minFee,
    bool? isFull,
    String? deadline,
    List<ProgramDuration>? durationInMonths,
    String? faculty,
    ProgramSortType? sortType,
  }) async {
    try {
      PaginatedResponseModel<ProgramModel> response =
          await _programRemoteDataSource.getPrograms(
        page: page,
        size: size,
        name: name,
        countryCode: countryCode?.map((e) => e.json).toList(),
        city: city,
        university: university,
        degreeType: degreeType?.map((e) => e.json).toList(),
        campusType: campusType?.map((e) => e.json).toList(),
        universityType: universityType?.map((e) => e.json).toList(),
        modeOfStudy: modeOfStudy?.map((e) => e.json).toList(),
        language: language?.map((e) => e.json).toList(),
        maxFee: maxFee,
        minFee: minFee,
        isFull: isFull,
        deadline: deadline,
        durationInMonths:
            durationInMonths?.map((e) => e.durationInMonths).toList(),
        faculty: faculty,
        sortType: sortType?.json,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<UniversityBasicDetails>>>
      getAvailableUniversityBasicDetails() async {
    try {
      List<UniversityBasicDetails> response =
          await _programRemoteDataSource.getIdsAndNames();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AvailableCountryCode>>>
      getAvailableCountries() async {
    try {
      List<AvailableCountryCode> response =
          await _programRemoteDataSource.getCountries();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

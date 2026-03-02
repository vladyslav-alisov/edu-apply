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
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';

abstract interface class ProgramRepository {
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
  });

  Future<Either<Failure, List<UniversityBasicDetails>>>
      getAvailableUniversityBasicDetails();

  Future<Either<Failure, List<AvailableCountryCode>>> getAvailableCountries();
}

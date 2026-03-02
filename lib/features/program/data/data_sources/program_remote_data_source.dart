import 'package:edu_apply/core/common/models/paginated_response_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/features/program/data/models/program_model.dart';
import 'package:edu_apply/features/program/data/models/university_basic_details_model.dart';

abstract interface class ProgramRemoteDataSource {
  Future<PaginatedResponseModel<ProgramModel>> getPrograms({
    int? page = 0,
    int? size = 10,
    String? name,
    List<String>? countryCode,
    List<String>? city,
    List<String>? university,
    List<String>? degreeType,
    List<String>? campusType,
    List<String>? modeOfStudy,
    List<String>? universityType,
    List<String>? language,
    double? maxFee,
    double? minFee,
    bool? isFull,
    String? deadline,
    List<int>? durationInMonths,
    String? faculty,
    String? sortType,
  });

  Future<List<UniversityBasicDetailsModel>> getIdsAndNames();

  Future<List<AvailableCountryCode>> getCountries();
}

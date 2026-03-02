import 'dart:math';

import 'package:edu_apply/core/common/models/pageable_model.dart';
import 'package:edu_apply/core/common/models/paginated_response_model.dart';
import 'package:edu_apply/core/common/models/sort_data_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/features/program/data/data_sources/country_dummy_data.dart';
import 'package:edu_apply/features/program/data/data_sources/program_dummy_data.dart';
import 'package:edu_apply/features/program/data/data_sources/program_remote_data_source.dart';
import 'package:edu_apply/features/program/data/data_sources/university_details_dummy_data.dart';
import 'package:edu_apply/features/program/data/models/program_model.dart';
import 'package:edu_apply/features/program/data/models/university_basic_details_model.dart';

class ProgramRemoteDataSourceDummyImpl implements ProgramRemoteDataSource {
  @override
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
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Apply filters
    List<ProgramModel> filtered = dummyPrograms.where((p) {
      if (name != null && name.isNotEmpty) {
        if (!p.name.toLowerCase().contains(name.toLowerCase())) return false;
      }
      if (countryCode != null && countryCode.isNotEmpty) {
        if (p.universityCountry == null ||
            !countryCode.contains(p.universityCountry!.json)) {
          return false;
        }
      }
      if (university != null && university.isNotEmpty) {
        if (!university.contains(p.universityName)) return false;
      }
      if (degreeType != null && degreeType.isNotEmpty) {
        if (!degreeType.contains(p.degreeType.json)) return false;
      }
      if (campusType != null && campusType.isNotEmpty) {
        if (!campusType.contains(p.campusType.json)) return false;
      }
      if (modeOfStudy != null && modeOfStudy.isNotEmpty) {
        if (!modeOfStudy.contains(p.modeOfStudy.json)) return false;
      }
      if (universityType != null && universityType.isNotEmpty) {
        if (!universityType.contains(p.universityType.json)) return false;
      }
      if (language != null && language.isNotEmpty) {
        if (!language.contains(p.language)) return false;
      }
      if (minFee != null && p.tuitionFee < minFee) return false;
      if (maxFee != null && p.tuitionFee > maxFee) return false;
      if (durationInMonths != null && durationInMonths.isNotEmpty) {
        if (!durationInMonths.contains(p.duration)) return false;
      }
      if (faculty != null && faculty.isNotEmpty) {
        if (!p.faculty.toLowerCase().contains(faculty.toLowerCase())) {
          return false;
        }
      }
      if (isFull != null) {
        final allFull = p.dates.every((d) => d.quotaIsFull);
        if (isFull != allFull) return false;
      }
      return true;
    }).toList();

    // Paginate filtered results
    final currentPage = page ?? 0;
    final pageSize = size ?? 10;
    final start = currentPage * pageSize;
    final end = min(start + pageSize, filtered.length);
    final pageContent = start < filtered.length
        ? filtered.sublist(start, end)
        : <ProgramModel>[];
    final totalPages = pageSize > 0 ? (filtered.length / pageSize).ceil() : 1;

    return PaginatedResponseModel<ProgramModel>(
      content: pageContent,
      pageable: PageableModel(
        pageNumber: currentPage,
        pageSize: pageSize,
        sort: SortDataModel(sorted: false, empty: true, unsorted: true),
        offset: start,
        paged: true,
        unpaged: false,
      ),
      totalPages: totalPages,
      totalElements: filtered.length,
      last: currentPage >= totalPages - 1,
      size: pageSize,
      number: currentPage,
      sort: SortDataModel(sorted: false, empty: true, unsorted: true),
      numberOfElements: pageContent.length,
      first: currentPage == 0,
      empty: pageContent.isEmpty,
    );
  }

  @override
  Future<List<AvailableCountryCode>> getCountries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyCountries;
  }

  @override
  Future<List<UniversityBasicDetailsModel>> getIdsAndNames() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyUniversityBasicDetails;
  }
}

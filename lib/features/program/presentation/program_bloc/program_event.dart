part of 'program_bloc.dart';

@immutable
sealed class ProgramEvent {
  final int? page;
  final int? size;
  final String name;
  final List<AvailableCountryCode>? countryCode;
  final List<String>? city;
  final List<UniversityBasicDetails>? university;
  final List<DegreeType>? degreeType;
  final List<CampusType>? campusType;
  final List<UniversityType>? universityType;
  final List<ModeOfStudy>? modeOfStudy;
  final List<AvailableLanguage>? language;
  final double? maxFee;
  final double? minFee;
  final bool? isFull;
  final String? deadline;
  final List<ProgramDuration>? durationInMonths;
  final String? faculty;
  final ProgramSortType? sortType;

  const ProgramEvent({
    this.page = 0,
    this.size = 10,
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

final class ProgramSearchPrograms extends ProgramEvent {
  const ProgramSearchPrograms({
    super.page,
    super.size,
    super.name,
    super.countryCode,
    super.city,
    super.university,
    super.degreeType,
    super.campusType,
    super.universityType,
    super.modeOfStudy,
    super.language,
    super.maxFee,
    super.minFee,
    super.isFull,
    super.deadline,
    super.durationInMonths,
    super.faculty,
    super.sortType,
  });
}

final class ProgramSearchProgramsMore extends ProgramEvent {
  const ProgramSearchProgramsMore({
    super.page,
    super.size,
    super.name,
    super.countryCode,
    super.city,
    super.university,
    super.degreeType,
    super.campusType,
    super.universityType,
    super.modeOfStudy,
    super.language,
    super.maxFee,
    super.minFee,
    super.isFull,
    super.deadline,
    super.durationInMonths,
    super.faculty,
    super.sortType,
  });
}

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdateSchoolParams {
  final String? schoolName;
  final String? degree;
  final AvailableCountryCode? country;
  final String? graduationYear;
  final String? cgpa;
  final File? diploma;
  final File? transcript;

  UpdateSchoolParams({
    this.schoolName,
    this.degree,
    this.country,
    this.graduationYear,
    this.cgpa,
    this.diploma,
    this.transcript,
  });
}

class UpdateSchool implements UseCase<Profile, UpdateSchoolParams> {
  UpdateSchool({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdateSchoolParams params) async {
    return await _profileRepository.updateSchoolInformation(
      schoolName: params.schoolName,
      degree: params.degree,
      country: params.country,
      graduationYear: params.graduationYear,
      cgpa: params.cgpa,
      diploma: params.diploma,
      transcript: params.transcript,
    );
  }
}

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdatePassportParams {
  final AvailableCountryCode? nationality;
  final String? passportNumber;
  final DateTime? issueDate;
  final DateTime? expireDate;
  final File? passportFile;

  UpdatePassportParams({
    required this.nationality,
    required this.passportNumber,
    required this.issueDate,
    required this.expireDate,
    required this.passportFile,
  });
}

class UpdatePassport implements UseCase<Profile, UpdatePassportParams> {
  UpdatePassport({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdatePassportParams params) async {
    return await _profileRepository.updatePassportInformation(
      nationality: params.nationality,
      passportNumber: params.passportNumber,
      issueDate: params.issueDate,
      expireDate: params.expireDate,
      passportFile: params.passportFile,
    );
  }
}

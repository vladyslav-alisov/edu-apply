import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdateLanguageCourseParams {
  final String? language;
  final DateTime? examDate;
  final String? grade;
  final File? certificate;

  UpdateLanguageCourseParams({
    required this.language,
    required this.examDate,
    required this.grade,
    required this.certificate,
  });
}

class UpdateLanguageCourse
    implements UseCase<Profile, UpdateLanguageCourseParams> {
  UpdateLanguageCourse({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(
      UpdateLanguageCourseParams params) async {
    return await _profileRepository.updateLanguageCourseInformation(
      language: params.language,
      examDate: params.examDate,
      grade: params.grade,
      certificate: params.certificate,
    );
  }
}

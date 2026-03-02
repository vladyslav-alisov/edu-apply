import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileImageParams {
  final File profileImage;

  UpdateProfileImageParams({
    required this.profileImage,
  });
}

class UpdateProfileImage implements UseCase<Profile, UpdateProfileImageParams> {
  UpdateProfileImage({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdateProfileImageParams params) async {
    return await _profileRepository.updateProfilePicture(
      image: params.profileImage,
    );
  }
}

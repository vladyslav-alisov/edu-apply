import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdateFamilyParams {
  final String? fatherFirstName;
  final String? motherFirstName;

  UpdateFamilyParams({
    required this.fatherFirstName,
    required this.motherFirstName,
  });
}

class UpdateFamily implements UseCase<Profile, UpdateFamilyParams> {
  UpdateFamily({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdateFamilyParams params) async {
    return await _profileRepository.updateFamilyInformation(
      fatherFirstName: params.fatherFirstName,
      motherFirstName: params.motherFirstName,
    );
  }
}

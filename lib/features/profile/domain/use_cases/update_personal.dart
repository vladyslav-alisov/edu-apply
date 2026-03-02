import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdatePersonalParams {
  final String firstName;
  final String lastName;
  final Gender? gender;
  final DateTime? birthdate;
  final String? fatherFirstName;
  final String? motherFirstName;

  UpdatePersonalParams({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.birthdate,
    required this.fatherFirstName,
    required this.motherFirstName,
  });
}

class UpdatePersonal implements UseCase<Profile, UpdatePersonalParams> {
  UpdatePersonal({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdatePersonalParams params) async {
    return await _profileRepository.updatePersonalInformation(
      firstName: params.firstName,
      lastName: params.lastName,
      gender: params.gender,
      birthdate: params.birthdate,
    );
  }
}

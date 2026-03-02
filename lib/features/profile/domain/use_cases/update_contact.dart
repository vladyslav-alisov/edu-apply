import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UpdateContactParams {
  final String? mobilePhone;
  final String? email;
  final AvailableCountryCode? countryOfResidence;
  final String? cityOfResidence;
  final String? address;

  UpdateContactParams({
    required this.mobilePhone,
    required this.email,
    this.countryOfResidence,
    this.cityOfResidence,
    this.address,
  });
}

class UpdateContact implements UseCase<Profile, UpdateContactParams> {
  UpdateContact({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdateContactParams params) async {
    return await _profileRepository.updateContactInformation(
      email: params.email,
      mobilePhone: params.mobilePhone,
      countryOfResidence: params.countryOfResidence,
      cityOfResidence: params.cityOfResidence,
      address: params.address,
    );
  }
}

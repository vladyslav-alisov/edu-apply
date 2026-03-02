import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, Profile>> getMyProfile();
  Future<Either<Failure, Profile>> updatePersonalInformation({
    required String firstName,
    required String lastName,
    Gender? gender,
    DateTime? birthdate,
    String? fatherFirstName,
    String? motherFirstName,
  });

  Future<Either<Failure, Profile>> updateContactInformation({
    String? mobilePhone,
    String? email,
    AvailableCountryCode? countryOfResidence,
    String? cityOfResidence,
    String? address,
  });

  Future<Either<Failure, Profile>> updateFamilyInformation({
    String? fatherFirstName,
    String? motherFirstName,
  });

  Future<Either<Failure, Profile>> updatePassportInformation({
    AvailableCountryCode? nationality,
    String? passportNumber,
    DateTime? issueDate,
    DateTime? expireDate,
    File? passportFile,
    bool? visaRequired,
  });

  Future<Either<Failure, Profile>> updateSchoolInformation({
    String? schoolName,
    String? degree,
    AvailableCountryCode? country,
    String? graduationYear,
    String? cgpa,
    File? diploma,
    File? transcript,
  });

  Future<Either<Failure, Profile>> updateLanguageCourseInformation({
    String? language,
    DateTime? examDate,
    String? grade,
    File? certificate,
  });

  Future<Either<Failure, Profile>> uploadDocument({
    required File document,
    required String documentName,
    String? grade,
  });

  Future<Either<Failure, Profile>> deleteDocument({
    required String id,
  });

  Future<Either<Failure, Profile>> updateProfilePicture({
    required File image,
  });
}

import 'dart:io';
import 'package:edu_apply/features/profile/data/models/profile_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel> getMyProfile();
  Future<ProfileModel> updatePersonalInformation({
    String? firstName,
    String? lastName,
    String? residenceCountry,
    String? residenceCity,
    String? nationality,
    String? phone,
    String? title,
    String? address,
    String? motherName,
    String? fatherName,
    String? email,
    String? agencyId,
    String? parentAgencyId,
    String? sex,
    String? birthdate,
    String? passportDateOfIssue,
    String? passportDateOfExpire,
    String? passportNumber,
    bool? needVisa,
    File? profilePicture,
    File? passportFile,
  });
  Future<ProfileModel> updateEducationInformation({
    /// For university
    String? nameOfSchool,
    String? countryCode,
    String? graduationYear,
    String? degreeName,
    String? cgpa,
    File? transcript,
    File? diploma,

    /// For certificate
    String? language,
    String? languageDateOfExam,
    String? languageExamGrade,
    File? languageExamCertificate,
  });

  Future<ProfileModel> deleteAdditionalDocument({
    required String id,
  });

  Future<ProfileModel> addAdditionalDocument({
    required File file,
    required String name,
    String? grade,
  });
}

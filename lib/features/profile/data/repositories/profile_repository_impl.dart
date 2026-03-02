import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/exceptions.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:edu_apply/features/profile/data/models/profile_model.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl({
    required ProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  @override
  Future<Either<Failure, Profile>> getMyProfile() async {
    try {
      ProfileModel result = await _profileRemoteDataSource.getMyProfile();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateContactInformation({
    String? mobilePhone,
    String? email,
    AvailableCountryCode? countryOfResidence,
    String? cityOfResidence,
    String? address,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updatePersonalInformation(
        email: email,
        phone: mobilePhone,
        residenceCountry: countryOfResidence?.json,
        residenceCity: cityOfResidence,
        address: address,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateFamilyInformation({
    String? fatherFirstName,
    String? motherFirstName,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updatePersonalInformation(
        fatherName: fatherFirstName,
        motherName: motherFirstName,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateLanguageCourseInformation({
    String? language,
    DateTime? examDate,
    String? grade,
    File? certificate,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updateEducationInformation(
        language: language,
        languageDateOfExam: examDate?.serverFormat,
        languageExamGrade: grade,
        languageExamCertificate: certificate,
      );

      if (certificate == null) {
        String? fileId = result.englishProficiencyExam?.certificate?.id;
        if (fileId != null) {
          await _profileRemoteDataSource.deleteAdditionalDocument(id: fileId);
        }
        result.englishProficiencyExam?.certificate = null;
      }

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updatePassportInformation({
    AvailableCountryCode? nationality,
    String? passportNumber,
    DateTime? issueDate,
    DateTime? expireDate,
    File? passportFile,
    bool? visaRequired,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updatePersonalInformation(
        nationality: nationality?.json,
        passportNumber: passportNumber,
        passportDateOfIssue: issueDate?.serverFormat,
        passportDateOfExpire: expireDate?.serverFormat,
        passportFile: passportFile,
        needVisa: visaRequired,
      );

      if (passportFile == null) {
        String? fileId = result.passport?.file?.id;
        if (fileId != null) {
          await _profileRemoteDataSource.deleteAdditionalDocument(id: fileId);
        }
        result.passport?.file = null;
      }
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updatePersonalInformation({
    required String firstName,
    required String lastName,
    Gender? gender,
    DateTime? birthdate,
    String? fatherFirstName,
    String? motherFirstName,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updatePersonalInformation(
        firstName: firstName,
        lastName: lastName,
        sex: gender?.json,
        birthdate: birthdate?.serverFormat,
        fatherName: fatherFirstName,
        motherName: motherFirstName,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateSchoolInformation({
    String? schoolName,
    String? degree,
    AvailableCountryCode? country,
    String? graduationYear,
    String? cgpa,
    File? diploma,
    File? transcript,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updateEducationInformation(
        nameOfSchool: schoolName,
        degreeName: degree,
        graduationYear: graduationYear,
        cgpa: cgpa,
        countryCode: country?.json,
        transcript: transcript,
        diploma: diploma,
      );

      if (diploma == null) {
        String? fileId = result.educationHistory?.diploma?.id;
        if (fileId != null) {
          await _profileRemoteDataSource.deleteAdditionalDocument(id: fileId);
        }
        result.educationHistory?.diploma = null;
      }

      if (transcript == null) {
        String? fileId = result.educationHistory?.transcript?.id;
        if (fileId != null) {
          await _profileRemoteDataSource.deleteAdditionalDocument(id: fileId);
        }
        result.educationHistory?.transcript = null;
      }

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> uploadDocument({
    required File document,
    required String documentName,
    String? grade,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.addAdditionalDocument(
        name: documentName,
        file: document,
        grade: grade,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> deleteDocument({
    required String id,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.deleteAdditionalDocument(id: id);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfilePicture({
    required File image,
  }) async {
    try {
      ProfileModel result =
          await _profileRemoteDataSource.updatePersonalInformation(
        profilePicture: image,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

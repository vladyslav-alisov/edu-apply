import 'dart:io';

import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/features/profile/data/data_sources/profile_dummy_data.dart';
import 'package:edu_apply/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:edu_apply/features/profile/data/models/language_proficiency_model.dart';
import 'package:edu_apply/features/profile/data/models/passport_Information_model.dart';
import 'package:edu_apply/features/profile/data/models/profile_model.dart';
import 'package:edu_apply/features/profile/data/models/student_education_model.dart';

class ProfileRemoteDataSourceDummyImpl implements ProfileRemoteDataSource {
  ProfileModel _profile = dummyProfile;

  @override
  Future<ProfileModel> getMyProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _profile;
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _profile = ProfileModel(
      id: _profile.id,
      workerId: _profile.workerId,
      agencyId: agencyId ?? _profile.agencyId,
      parentAgencyId: parentAgencyId ?? _profile.parentAgencyId,
      counsellorId: _profile.counsellorId,
      referrerId: _profile.referrerId,
      email: email ?? _profile.email,
      firstName: firstName ?? _profile.firstName,
      lastName: lastName ?? _profile.lastName,
      agencyName: _profile.agencyName,
      password: _profile.password,
      residenceCountry: residenceCountry != null
          ? AvailableCountryCode.fromString(residenceCountry)
          : _profile.residenceCountry,
      nationality: nationality != null
          ? AvailableCountryCode.fromString(nationality)
          : _profile.nationality,
      sex: sex != null
          ? Gender.values
              .firstWhere((e) => e.json == sex, orElse: () => _profile.sex)
          : _profile.sex,
      source: _profile.source,
      residenceCity: residenceCity ?? _profile.residenceCity,
      address: address ?? _profile.address,
      title: title ?? _profile.title,
      motherName: motherName ?? _profile.motherName,
      fatherName: fatherName ?? _profile.fatherName,
      phone: phone ?? _profile.phone,
      birthdate:
          birthdate != null ? DateTime.tryParse(birthdate) : _profile.birthdate,
      educationHistory: _profile.educationHistory,
      profilePicture: profilePicture != null
          ? AttachmentModel(
              id: 'att-profile-pic-updated',
              url: profilePicture.path,
              fileType: 'image/jpeg',
              size: 2048,
            )
          : _profile.profilePicture,
      passport: PassportInformationModel(
        id: _profile.passport?.id ?? 'passport-001',
        studentId: _profile.id,
        dateOfIssue: passportDateOfIssue != null
            ? DateTime.tryParse(passportDateOfIssue)
            : _profile.passport?.dateOfIssue,
        dateOfExpire: passportDateOfExpire != null
            ? DateTime.tryParse(passportDateOfExpire)
            : _profile.passport?.dateOfExpire,
        passportNumber: passportNumber ?? _profile.passport?.passportNumber,
        needVisa: needVisa ?? _profile.passport?.needVisa,
        file: passportFile != null
            ? AdditionalDocumentModel(
                id: 'doc-passport-updated',
                studentId: _profile.id,
                file: AttachmentModel(
                  id: 'att-passport-updated',
                  url: passportFile.path,
                  fileType: 'application/pdf',
                  size: 4096,
                ),
                name: 'Passport Scan',
                grade: null,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              )
            : _profile.passport?.file,
      ),
      englishProficiencyExam: _profile.englishProficiencyExam,
      additionalDocuments: _profile.additionalDocuments,
      isVerified: _profile.isVerified,
      referrerUserRole: _profile.referrerUserRole,
    );

    return _profile;
  }

  @override
  Future<ProfileModel> updateEducationInformation({
    String? nameOfSchool,
    String? countryCode,
    String? graduationYear,
    String? degreeName,
    String? cgpa,
    File? transcript,
    File? diploma,
    String? language,
    String? languageDateOfExam,
    String? languageExamGrade,
    File? languageExamCertificate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final oldEdu = _profile.educationHistory;

    _profile = ProfileModel(
      id: _profile.id,
      workerId: _profile.workerId,
      agencyId: _profile.agencyId,
      parentAgencyId: _profile.parentAgencyId,
      counsellorId: _profile.counsellorId,
      referrerId: _profile.referrerId,
      email: _profile.email,
      firstName: _profile.firstName,
      lastName: _profile.lastName,
      agencyName: _profile.agencyName,
      password: _profile.password,
      residenceCountry: _profile.residenceCountry,
      nationality: _profile.nationality,
      sex: _profile.sex,
      source: _profile.source,
      residenceCity: _profile.residenceCity,
      address: _profile.address,
      title: _profile.title,
      motherName: _profile.motherName,
      fatherName: _profile.fatherName,
      phone: _profile.phone,
      birthdate: _profile.birthdate,
      educationHistory: StudentEducationModel(
        id: oldEdu?.id ?? 'edu-001',
        studentId: _profile.id,
        nameOfSchool: nameOfSchool ?? oldEdu?.nameOfSchool,
        countryCode: countryCode != null
            ? AvailableCountryCode.fromString(countryCode)
            : oldEdu?.countryCode,
        graduationYear: graduationYear ?? oldEdu?.graduationYear,
        degreeName: degreeName ?? oldEdu?.degreeName,
        cgpa: cgpa ?? oldEdu?.cgpa,
        transcript: transcript != null
            ? _fileToDocument('transcript-updated', 'Transcript', transcript)
            : oldEdu?.transcript,
        diploma: diploma != null
            ? _fileToDocument('diploma-updated', 'Diploma', diploma)
            : oldEdu?.diploma,
      ),
      profilePicture: _profile.profilePicture,
      passport: _profile.passport,
      englishProficiencyExam: language != null
          ? LanguageProficiencyModel(
              id: _profile.englishProficiencyExam?.id ?? 'lang-001',
              studentId: _profile.id,
              language: language,
              dateOfExam: languageDateOfExam != null
                  ? DateTime.tryParse(languageDateOfExam)
                  : _profile.englishProficiencyExam?.dateOfExam,
              grade:
                  languageExamGrade ?? _profile.englishProficiencyExam?.grade,
              certificate: languageExamCertificate != null
                  ? _fileToDocument('lang-cert-updated', 'Language Certificate',
                      languageExamCertificate)
                  : _profile.englishProficiencyExam?.certificate,
            )
          : _profile.englishProficiencyExam,
      additionalDocuments: _profile.additionalDocuments,
      isVerified: _profile.isVerified,
      referrerUserRole: _profile.referrerUserRole,
    );

    return _profile;
  }

  @override
  Future<ProfileModel> deleteAdditionalDocument({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final updatedDocs =
        _profile.additionalDocuments.where((doc) => doc.id != id).toList();

    _profile = ProfileModel(
      id: _profile.id,
      workerId: _profile.workerId,
      agencyId: _profile.agencyId,
      parentAgencyId: _profile.parentAgencyId,
      counsellorId: _profile.counsellorId,
      referrerId: _profile.referrerId,
      email: _profile.email,
      firstName: _profile.firstName,
      lastName: _profile.lastName,
      agencyName: _profile.agencyName,
      password: _profile.password,
      residenceCountry: _profile.residenceCountry,
      nationality: _profile.nationality,
      sex: _profile.sex,
      source: _profile.source,
      residenceCity: _profile.residenceCity,
      address: _profile.address,
      title: _profile.title,
      motherName: _profile.motherName,
      fatherName: _profile.fatherName,
      phone: _profile.phone,
      birthdate: _profile.birthdate,
      educationHistory: _profile.educationHistory,
      profilePicture: _profile.profilePicture,
      passport: _profile.passport,
      englishProficiencyExam: _profile.englishProficiencyExam,
      additionalDocuments: updatedDocs,
      isVerified: _profile.isVerified,
      referrerUserRole: _profile.referrerUserRole,
    );

    return _profile;
  }

  @override
  Future<ProfileModel> addAdditionalDocument({
    required File file,
    required String name,
    String? grade,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final newDoc = AdditionalDocumentModel(
      id: 'doc-additional-${DateTime.now().millisecondsSinceEpoch}',
      studentId: _profile.id,
      file: AttachmentModel(
        id: 'att-additional-${DateTime.now().millisecondsSinceEpoch}',
        url: file.path,
        fileType: 'application/pdf',
        size: 2048,
      ),
      name: name,
      grade: grade,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _profile = ProfileModel(
      id: _profile.id,
      workerId: _profile.workerId,
      agencyId: _profile.agencyId,
      parentAgencyId: _profile.parentAgencyId,
      counsellorId: _profile.counsellorId,
      referrerId: _profile.referrerId,
      email: _profile.email,
      firstName: _profile.firstName,
      lastName: _profile.lastName,
      agencyName: _profile.agencyName,
      password: _profile.password,
      residenceCountry: _profile.residenceCountry,
      nationality: _profile.nationality,
      sex: _profile.sex,
      source: _profile.source,
      residenceCity: _profile.residenceCity,
      address: _profile.address,
      title: _profile.title,
      motherName: _profile.motherName,
      fatherName: _profile.fatherName,
      phone: _profile.phone,
      birthdate: _profile.birthdate,
      educationHistory: _profile.educationHistory,
      profilePicture: _profile.profilePicture,
      passport: _profile.passport,
      englishProficiencyExam: _profile.englishProficiencyExam,
      additionalDocuments: [..._profile.additionalDocuments, newDoc],
      isVerified: _profile.isVerified,
      referrerUserRole: _profile.referrerUserRole,
    );

    return _profile;
  }

  // Helper to convert a File into an AdditionalDocumentModel
  AdditionalDocumentModel _fileToDocument(String id, String name, File file) {
    return AdditionalDocumentModel(
      id: 'doc-$id',
      studentId: _profile.id,
      file: AttachmentModel(
        id: 'att-$id',
        url: file.path,
        fileType: 'application/pdf',
        size: 4096,
      ),
      name: name,
      grade: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

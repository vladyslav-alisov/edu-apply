import 'package:equatable/equatable.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/entities/attachment.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/source.dart';
import 'package:edu_apply/features/profile/domain/entities/language_proficiency.dart';
import 'package:edu_apply/features/profile/domain/entities/passport_information.dart';
import 'package:edu_apply/features/profile/domain/entities/student_education.dart';

class Profile extends Equatable {
  final String id;
  final String? workerId;
  final String? agencyId;
  final String? parentAgencyId;
  final String? counsellorId;
  final String? referrerId;
  final String email;
  final String firstName;
  final String lastName;
  final String? agencyName;
  final String? password;
  final AvailableCountryCode? residenceCountry;
  final AvailableCountryCode? nationality;
  final Gender sex;
  final Source? source;
  final String? residenceCity;
  final String? address;
  final String? title;
  final String? motherName;
  final String? fatherName;
  final String? phone;
  final DateTime? birthdate;
  final StudentEducation? educationHistory;
  final Attachment? profilePicture;
  final PassportInformation? passport;
  final LanguageProficiency? englishProficiencyExam;
  final List<AdditionalDocument> additionalDocuments;
  final bool isVerified;
  final String? referrerUserRole;

  const Profile({
    required this.id,
    required this.workerId,
    required this.agencyId,
    required this.parentAgencyId,
    required this.counsellorId,
    required this.referrerId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.agencyName,
    required this.password,
    required this.residenceCountry,
    required this.nationality,
    required this.sex,
    required this.source,
    required this.residenceCity,
    required this.address,
    required this.title,
    required this.motherName,
    required this.fatherName,
    required this.phone,
    required this.birthdate,
    required this.educationHistory,
    required this.profilePicture,
    required this.passport,
    required this.englishProficiencyExam,
    required this.additionalDocuments,
    required this.isVerified,
    required this.referrerUserRole,
  });

  String get fullName => "$firstName $lastName";

  @override
  String toString() {
    return 'Profile{id: $id, workerId: $workerId, agencyId: $agencyId, parentAgencyId: $parentAgencyId, counsellorId: $counsellorId, referrerId: $referrerId, email: $email, firstName: $firstName, lastName: $lastName, agencyName: $agencyName, password: $password, residenceCountry: $residenceCountry, nationality: $nationality, sex: $sex, source: $source, residenceCity: $residenceCity, address: $address, title: $title, motherName: $motherName, fatherName: $fatherName, phone: $phone, birthdate: $birthdate, educationHistory: $educationHistory, profilePicture: $profilePicture, passport: $passport, englishProficiencyExam: $englishProficiencyExam, additionalDocuments: $additionalDocuments, isVerified: $isVerified, referrerUserRole: $referrerUserRole}';
  }

  @override
  List<Object?> get props => [
        id,
        workerId,
        agencyId,
        parentAgencyId,
        counsellorId,
        referrerId,
        email,
        firstName,
        lastName,
        agencyName,
        password,
        residenceCountry,
        nationality,
        sex,
        source,
        residenceCity,
        address,
        title,
        motherName,
        fatherName,
        phone,
        birthdate,
        educationHistory,
        profilePicture,
        passport,
        englishProficiencyExam,
        additionalDocuments,
        isVerified,
        referrerUserRole,
      ];
}

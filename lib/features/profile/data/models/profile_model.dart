import 'package:collection/collection.dart';
import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/source.dart';
import 'package:edu_apply/features/profile/data/models/language_proficiency_model.dart';
import 'package:edu_apply/features/profile/data/models/passport_Information_model.dart';
import 'package:edu_apply/features/profile/data/models/student_education_model.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.workerId,
    required super.agencyId,
    required super.parentAgencyId,
    required super.counsellorId,
    required super.referrerId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.agencyName,
    required super.password,
    required super.residenceCountry,
    required super.nationality,
    required super.sex,
    required super.source,
    required super.residenceCity,
    required super.address,
    required super.title,
    required super.motherName,
    required super.fatherName,
    required super.phone,
    required super.birthdate,
    required super.educationHistory,
    required super.profilePicture,
    required super.passport,
    required super.englishProficiencyExam,
    required super.additionalDocuments,
    required super.isVerified,
    required super.referrerUserRole,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        workerId: json["workerId"],
        agencyId: json["agencyId"],
        parentAgencyId: json["parentAgencyId"],
        counsellorId: json["counsellorId"],
        referrerId: json["referrerId"],
        email: json["email"] ?? "",
        firstName: json["firstName"],
        lastName: json["lastName"],
        agencyName: json["agencyName"],
        password: json["password"],
        residenceCountry: AvailableCountryCode.values.firstWhereOrNull(
          (element) => element.json == json["residenceCountry"],
        ),
        nationality: AvailableCountryCode.values.firstWhereOrNull(
          (element) => element.json == json["nationality"],
        ),
        sex: Gender.values.firstWhereOrNull((e) => e.json == json["sex"]) ??
            Gender.male,
        source: Source.values.firstWhere((e) => e.json == json["source"],
            orElse: () => Source.website),
        residenceCity: json["residenceCity"],
        address: json["address"],
        title: json["title"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        phone: json["phone"],
        birthdate: json["birthdate"] != null
            ? DateTime.tryParse(json["birthdate"])
            : json["birthdate"],
        educationHistory: json["educationHistory"] == null
            ? null
            : StudentEducationModel.fromJson(json["educationHistory"]),
        profilePicture: json["profilePicture"] == null
            ? null
            : AttachmentModel.fromJson(json["profilePicture"]),
        passport: json["passport"] == null
            ? null
            : PassportInformationModel.fromJson(json["passport"]),
        englishProficiencyExam: json["englishProficiencyExam"] == null
            ? null
            : LanguageProficiencyModel.fromJson(json["englishProficiencyExam"]),
        additionalDocuments: json["additionalDocuments"] == null
            ? []
            : List<AdditionalDocumentModel>.from(
                json["additionalDocuments"]!.map(
                  (x) => AdditionalDocumentModel.fromJson(x),
                ),
              ),
        isVerified: json["isVerified"] ?? false,
        referrerUserRole: json["referrerUserRole"],
      );
}

import 'package:collection/collection.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/currency.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/features/program/data/models/program_application_date_model.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';

class ProgramModel extends Program {
  ProgramModel({
    required super.id,
    required super.universityId,
    required super.language,
    required super.name,
    required super.description,
    required super.websiteUrl,
    required super.category,
    required super.faculty,
    required super.applicationStartDate,
    required super.applicationEndDate,
    required super.scope,
    required super.programStartMonth,
    required super.dates,
    required super.currency,
    required super.degreeType,
    required super.modeOfStudy,
    required super.campusType,
    required super.tuitionFee,
    required super.deposit,
    required super.image,
    required super.brochure,
    required super.duration,
    required super.discountPercentage,
    required super.numberOfInstallations,
    required super.siblingDiscountPercentage,
    required super.cashPaymentDiscountPercentage,
    required super.universityName,
    required super.universityType,
    required super.universityCountry,
    required super.maximumCommission,
    required super.universityImage,
    required super.universityLogo,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json["id"],
        language: json["language"],
        universityId: json["universityId"],
        name: json["name"],
        description: json["description"],
        websiteUrl: json["websiteUrl"],
        category: json["category"],
        faculty: json["faculty"],
        applicationStartDate: DateTime.parse(json["applicationStartDate"]),
        applicationEndDate: DateTime.parse(json["applicationEndDate"]),
        scope: json["scope"],
        programStartMonth:
            DateTime.tryParse(json["programStartMonth"] + "-01") ??
                DateTime.now(),
        dates: List<ProgramApplicationDateModel>.from(
            json["dates"].map((x) => ProgramApplicationDateModel.fromJson(x))),
        currency: Currency.values.firstWhereOrNull(
                (element) => element.json == json["currency"]) ??
            Currency.usd,
        degreeType: DegreeType.values
            .firstWhere((element) => json["degreeType"] == element.json),
        modeOfStudy: ModeOfStudy.values
            .firstWhere((element) => json["modeOfStudy"] == element.json),
        campusType: CampusType.values
            .firstWhere((element) => json["campusType"] == element.json),
        tuitionFee: json["tuitionFee"] ?? 0,
        deposit: json["deposit"],
        image: json["image"],
        brochure: json["brochure"],
        duration: json["duration"],
        discountPercentage: json["discountPercentage"],
        numberOfInstallations: json["numberOfInstallations"],
        siblingDiscountPercentage: json["siblingDiscountPercentage"],
        cashPaymentDiscountPercentage: json["cashPaymentDiscountPercentage"],
        universityName: json["universityName"],
        universityType: UniversityType.values
            .firstWhere((element) => element.json == json["universityType"]),
        universityCountry: AvailableCountryCode.values.firstWhereOrNull(
            (element) => element.json == json["universityCountry"]),
        maximumCommission: json["maximumCommission"],
        universityImage: AttachmentModel.fromJson(json["universityImage"]),
        universityLogo: AttachmentModel.fromJson(json["universityLogo"]),
      );
}

import 'package:edu_apply/core/const/enums/application_status.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/currency.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/source.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';

class ApplicationModel extends Application {
  ApplicationModel({
    required super.id,
    required super.counsellorId,
    required super.universityProgramId,
    required super.universityId,
    required super.agencyId,
    required super.parentAgencyId,
    required super.workerId,
    required super.studentId,
    required super.periodId,
    required super.periodLabel,
    required super.periodYear,
    required super.code,
    required super.universityProgramName,
    required super.programStartMonth,
    required super.universityName,
    required super.universityApplyCode,
    required super.agencyName,
    required super.workerName,
    required super.studentName,
    required super.counsellorName,
    required super.agencyType,
    required super.educationLanguage,
    required super.source,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.tuitionFee,
    required super.amountPaid,
    required super.amountToPay,
    required super.discountPercentageGiven,
    required super.degreeType,
    required super.campusType,
    required super.studentCountry,
    required super.universityType,
    required super.lastStatusMessage,
    required super.approved,
    required super.applied,
    required super.tuitionCurrency,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        id: json["id"],
        counsellorId: json["counsellorId"],
        universityProgramId: json["universityProgramId"],
        universityId: json["universityId"],
        agencyId: json["agencyId"],
        parentAgencyId: json["parentAgencyId"],
        workerId: json["workerId"],
        studentId: json["studentId"],
        periodId: json["periodId"] ?? "",
        periodLabel: json["periodLabel"] ?? "",
        periodYear: json["periodYear"] ?? "",
        code: json["code"],
        universityProgramName: json["universityProgramName"],
        programStartMonth:
            DateTime.tryParse(json["programStartMonth"] + "-01") ??
                DateTime.now(),
        universityName: json["universityName"] ?? "",
        universityApplyCode: json["universityApplyCode"] ?? "",
        agencyName: json["agencyName"],
        workerName: json["workerName"] ?? "",
        studentName: json["studentName"] ?? "",
        counsellorName: json["counsellorName"],
        agencyType: json["agencyType"],
        educationLanguage: json["educationLanguage"] ?? "",
        source: Source.fromString(json["source"]),
        status: ApplicationStatus.fromString(json["status"]) ??
            ApplicationStatus.newApplication,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        tuitionFee: json["tuitionFee"] ?? 0,
        amountPaid: json["amountPaid"] ?? 0,
        amountToPay: json["amountToPay"] ?? 0,
        discountPercentageGiven: json["discountPercentageGiven"] ?? 0,
        degreeType: DegreeType.fromString(json["degreeType"]),
        campusType: CampusType.fromString(json["campusType"]),
        studentCountry: AvailableCountryCode.fromString(json["studentCountry"]),
        universityType: UniversityType.fromString(json["universityType"]),
        lastStatusMessage: json["lastStatusMessage"],
        approved: json["approved"] ?? false,
        applied: json["applied"] ?? false,
        tuitionCurrency:
            Currency.fromString(json["tuitionCurrency"]) ?? Currency.usd,
      );
}

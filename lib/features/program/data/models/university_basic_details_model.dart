import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';

class UniversityBasicDetailsModel extends UniversityBasicDetails {
  UniversityBasicDetailsModel({
    required super.logo,
    required super.id,
    required super.name,
    required super.city,
    required super.degreeTypes,
    required super.longitude,
    required super.latitude,
    required super.country,
  });

  factory UniversityBasicDetailsModel.fromJson(Map<String, dynamic> json) =>
      UniversityBasicDetailsModel(
        logo: AttachmentModel.fromJson(json["logo"]),
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        city: json["city"] ?? "",
        degreeTypes: json["degreeTypes"] ?? "",
        longitude: json["longitude"] ?? 0,
        latitude: json["latitude"] ?? 0,
        country: AvailableCountryCode.fromString(json["country"]),
      );
}

import 'package:edu_apply/core/common/entities/attachment.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';

class UniversityBasicDetails {
  Attachment logo;
  String id;
  String name;
  String city;
  String degreeTypes;
  double longitude;
  double latitude;
  AvailableCountryCode? country;

  UniversityBasicDetails({
    required this.logo,
    required this.id,
    required this.name,
    required this.city,
    required this.degreeTypes,
    required this.longitude,
    required this.latitude,
    required this.country,
  });
}

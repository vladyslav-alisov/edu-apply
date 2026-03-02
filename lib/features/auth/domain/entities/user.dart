import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/user_role.dart';

class User {
  String id;
  String? agencyId;
  String? parentAgencyId;
  String? counsellorId;
  String? referrerId;
  String email;
  String firstName;
  String lastName;
  String authProvider;
  Gender sex;
  UserRole role;
  String accessToken;
  String idToken;
  String? errorMessage;
  String? referralCode;
  bool isVerified;
  UserRole? referrerUserRole;

  User({
    required this.id,
    this.agencyId,
    this.parentAgencyId,
    this.counsellorId,
    this.referrerId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.authProvider,
    required this.sex,
    required this.role,
    required this.accessToken,
    required this.idToken,
    this.errorMessage,
    this.referralCode,
    required this.isVerified,
    this.referrerUserRole,
  });
}

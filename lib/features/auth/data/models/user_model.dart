import 'package:collection/collection.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/user_role.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.authProvider,
    required super.sex,
    required super.role,
    required super.accessToken,
    required super.idToken,
    required super.isVerified,
    super.agencyId,
    super.parentAgencyId,
    super.counsellorId,
    super.referrerId,
    super.errorMessage,
    super.referralCode,
    super.referrerUserRole,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        agencyId: json["agencyId"],
        parentAgencyId: json["parentAgencyId"],
        counsellorId: json["counsellorId"],
        referrerId: json["referrerId"],
        email: json["email"],
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        authProvider: json["authProvider"] ?? "email",
        sex: Gender.values.firstWhereOrNull((e) => e.json == json["sex"]) ??
            Gender.male,
        role: UserRole.values.firstWhereOrNull((e) => e.json == json["role"]) ??
            UserRole.unknown,
        accessToken: json["accessToken"] ?? "",
        idToken: json["idToken"] ?? "",
        errorMessage: json["errorMessage"],
        referralCode: json["referralCode"],
        isVerified: json["isVerified"] ?? false,
        referrerUserRole: UserRole.values
            .firstWhereOrNull((e) => e.json == json["referrerUserRole"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "agencyId": agencyId,
        "parentAgencyId": parentAgencyId,
        "counsellorId": counsellorId,
        "referrerId": referrerId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "authProvider": authProvider,
        "sex": sex,
        "role": role,
        "accessToken": accessToken,
        "idToken": idToken,
        "errorMessage": errorMessage,
        "referralCode": referralCode,
        "isVerified": isVerified,
        "referrerUserRole": referrerUserRole,
      };
}

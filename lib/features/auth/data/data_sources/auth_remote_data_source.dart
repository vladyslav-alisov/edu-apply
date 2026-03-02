import 'package:edu_apply/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String sex,
    required String phone,
    String? agencyId,
    String? parentAgencyId,
    String? counsellorId,
    String? usedReferralCode,
  });

  Future<String> sendForgotPassword({
    required String email,
  });

  Future<UserModel> fetchUser();
}

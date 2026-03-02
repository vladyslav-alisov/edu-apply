import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/user_role.dart';
import 'package:edu_apply/features/auth/data/data_sources/auth_dummy_data.dart';
import 'package:edu_apply/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:edu_apply/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceDummyImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return dummyUser;
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return UserModel(
      id: 'student-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      firstName: firstName,
      lastName: lastName,
      authProvider: 'email',
      sex: Gender.values.firstWhere(
        (e) => e.json == sex,
        orElse: () => Gender.male,
      ),
      role: UserRole.student,
      accessToken:
          'dummy-access-token-${DateTime.now().millisecondsSinceEpoch}',
      idToken: 'dummy-id-token-${DateTime.now().millisecondsSinceEpoch}',
      isVerified: false,
      agencyId: agencyId,
      parentAgencyId: parentAgencyId,
      counsellorId: counsellorId,
      referralCode: null,
      referrerUserRole: null,
    );
  }

  @override
  Future<String> sendForgotPassword({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return email;
  }

  @override
  Future<UserModel> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyUser;
  }
}

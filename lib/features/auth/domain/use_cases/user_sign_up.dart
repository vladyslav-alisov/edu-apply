import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';
import 'package:edu_apply/features/auth/domain/repositories/auth_repository.dart';

class UserSignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final Gender sex;
  final String phone;
  final String? usedReferralCode;
  final String? parentAgencyId;
  final String? counsellorId;
  final String? agencyId;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.phone,
    this.usedReferralCode,
    this.parentAgencyId,
    this.counsellorId,
    this.agencyId,
  });
}

class UserSignUp implements UseCase<User, UserSignUpParams> {
  UserSignUp(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signUp(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      sex: params.sex,
      phone: params.phone,
      usedReferralCode: params.usedReferralCode,
      parentAgencyId: params.parentAgencyId,
      counsellorId: params.counsellorId,
      agencyId: params.agencyId,
    );
  }
}

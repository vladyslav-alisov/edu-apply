import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> tryLoginWithToken();

  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required Gender sex,
    required String phone,
    String? agencyId,
    String? parentAgencyId,
    String? counsellorId,
    String? usedReferralCode,
  });

  Future<Either<Failure, String>> sendForgotPassword({
    required String email,
  });
}

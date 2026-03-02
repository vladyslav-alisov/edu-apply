import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/error/exceptions.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/features/auth/data/data_sources/auth_persistent_data_source.dart';
import 'package:edu_apply/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:edu_apply/features/auth/data/models/user_model.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';
import 'package:edu_apply/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthPersistentDataSource _authPersistentDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthPersistentDataSource authPersistentDataSource,
  })  : _authPersistentDataSource = authPersistentDataSource,
        _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel =
          await _authRemoteDataSource.login(email: email, password: password);
      await _authPersistentDataSource.saveAccessToken(userModel.accessToken);
      await _authPersistentDataSource.saveRefreshToken(userModel.idToken);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on PersistenceException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
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
  }) async {
    try {
      UserModel userModel = await _authRemoteDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        sex: sex.json,
        phone: phone,
        agencyId: agencyId,
        counsellorId: counsellorId,
        parentAgencyId: parentAgencyId,
        usedReferralCode: usedReferralCode,
      );
      await _authPersistentDataSource.saveAccessToken(userModel.accessToken);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on PersistenceException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendForgotPassword(
      {required String email}) async {
    try {
      String sentTo =
          await _authRemoteDataSource.sendForgotPassword(email: email);
      return right(sentTo);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> tryLoginWithToken() async {
    try {
      final accessToken = await _authPersistentDataSource.getAccessToken();
      if (accessToken == null) {
        return left(Failure("Access token not found"));
      }
      UserModel userModel = await _authRemoteDataSource.fetchUser();
      await _authPersistentDataSource.saveAccessToken(userModel.accessToken);
      await _authPersistentDataSource.saveRefreshToken(userModel.idToken);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

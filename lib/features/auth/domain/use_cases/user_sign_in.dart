import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';
import 'package:edu_apply/features/auth/domain/repositories/auth_repository.dart';

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}

class UserSignIn implements UseCase<User, UserSignInParams> {
  UserSignIn(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

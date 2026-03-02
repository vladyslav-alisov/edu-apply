import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/auth/domain/repositories/auth_repository.dart';

class UserForgotPasswordParams {
  final String email;

  UserForgotPasswordParams({required this.email});
}

class UserForgotPassword implements UseCase<String, UserForgotPasswordParams> {
  UserForgotPassword(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, String>> call(UserForgotPasswordParams params) async {
    return await _authRepository.sendForgotPassword(
      email: params.email,
    );
  }
}

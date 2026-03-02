import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';
import 'package:edu_apply/features/auth/domain/repositories/auth_repository.dart';

class UserTryLoginWithToken implements UseCase<User, NoParams> {
  UserTryLoginWithToken(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.tryLoginWithToken();
  }
}

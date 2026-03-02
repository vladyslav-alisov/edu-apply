import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class DeleteDocumentParams {
  final String id;

  DeleteDocumentParams({
    required this.id,
  });
}

class DeleteDocument implements UseCase<Profile, DeleteDocumentParams> {
  DeleteDocument({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(DeleteDocumentParams params) async {
    return await _profileRepository.deleteDocument(
      id: params.id,
    );
  }
}

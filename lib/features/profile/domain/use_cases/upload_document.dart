import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/repositories/profile_repository.dart';

class UploadDocumentParams {
  final File document;
  final String documentName;
  final String? grade;

  UploadDocumentParams({
    required this.document,
    required this.documentName,
    this.grade,
  });
}

class UploadDocument implements UseCase<Profile, UploadDocumentParams> {
  UploadDocument({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UploadDocumentParams params) async {
    return await _profileRepository.uploadDocument(
      document: params.document,
      documentName: params.documentName,
      grade: params.grade,
    );
  }
}

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/error/failure.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/application/domain/repositories/application_repository.dart';

class AddFileParams {
  final String name;
  final File file;
  final String applicationId;

  AddFileParams({
    required this.name,
    required this.file,
    required this.applicationId,
  });
}

class AddFile implements UseCase<AdditionalDocument, AddFileParams> {
  final ApplicationRepository _applicationRepository;

  AddFile({
    required ApplicationRepository applicationRepository,
  }) : _applicationRepository = applicationRepository;

  @override
  Future<Either<Failure, AdditionalDocument>> call(
    AddFileParams params,
  ) async {
    return await _applicationRepository.addFile(
      name: params.name,
      file: params.file,
      applicationId: params.applicationId,
    );
  }
}

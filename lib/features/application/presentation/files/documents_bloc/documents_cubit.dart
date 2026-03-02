import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/features/application/domain/use_cases/add_file.dart';
import 'package:edu_apply/features/application/domain/use_cases/get_files.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit({
    required AddFile addFile,
    required GetFiles getFiles,
  })  : _addFile = addFile,
        _getFiles = getFiles,
        super(DocumentsInitial(documents: []));

  final AddFile _addFile;
  final GetFiles _getFiles;

  void addDocument({
    required String name,
    required File file,
    required String applicationId,
  }) async {
    emit(DocumentsLoading(documents: [...state.documents]));

    var result = await _addFile.call(
      AddFileParams(
        name: name,
        file: file,
        applicationId: applicationId,
      ),
    );

    result.fold(
      (l) => emit(DocumentsFailure(
          documents: [...state.documents], message: l.message)),
      (r) => emit(DocumentsAddedSuccess(documents: [...state.documents, r])),
    );
  }

  void fetchDocuments({
    required String applicationId,
  }) async {
    emit(DocumentsLoading(documents: [...state.documents]));

    var result = await _getFiles.call(
      GetFilesParams(
        applicationId: applicationId,
      ),
    );

    result.fold(
      (l) => emit(DocumentsFailure(
          documents: [...state.documents], message: l.message)),
      (r) => emit(DocumentsSuccess(documents: [...r.content])),
    );
  }
}

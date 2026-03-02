part of 'documents_cubit.dart';

@immutable
sealed class DocumentsState {
  final List<AdditionalDocument> documents;

  const DocumentsState({required this.documents});
}

final class DocumentsInitial extends DocumentsState {
  const DocumentsInitial({required super.documents});
}

final class DocumentsLoading extends DocumentsState {
  const DocumentsLoading({required super.documents});
}

final class DocumentsSuccess extends DocumentsState {
  const DocumentsSuccess({required super.documents});
}

final class DocumentsFailure extends DocumentsState {
  final String message;
  const DocumentsFailure({required super.documents, required this.message});
}

final class DocumentsAddedSuccess extends DocumentsState {
  const DocumentsAddedSuccess({required super.documents});
}

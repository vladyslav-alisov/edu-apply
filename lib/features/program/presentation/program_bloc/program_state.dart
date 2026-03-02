part of 'program_bloc.dart';

enum ProgramStateStatus {
  initLoading,
  fetchLoading,
  success,
  failure,
  fetchMoreLoading;
}

@immutable
class ProgramState extends Equatable {
  final ProgramStateStatus status;
  final List<Program> programList;
  final String message;
  final bool isLastPage;
  final int currentPage;
  final int totalElements;

  const ProgramState({
    required this.status,
    required this.programList,
    required this.message,
    required this.totalElements,
    required this.currentPage,
    required this.isLastPage,
  });

  ProgramState copyWith({
    ProgramStateStatus? status,
    List<Program>? programList,
    String? message,
    bool? isLastPage,
    int? currentPage,
    int? totalElements,
  }) {
    return ProgramState(
      status: status ?? this.status,
      programList: programList ?? this.programList,
      message: message ?? "",
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      totalElements: totalElements ?? this.totalElements,
    );
  }

  @override
  List<Object?> get props => [
        status,
        programList,
        message,
        isLastPage,
        currentPage,
        totalElements,
      ];
}

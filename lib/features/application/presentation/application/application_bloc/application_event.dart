part of 'application_bloc.dart';

@immutable
sealed class ApplicationEvent {}

class ApplicationFetch extends ApplicationEvent {
  final int size;
  final int page;

  ApplicationFetch({
    this.size = 10,
    this.page = 0,
  });
}

class ApplicationCreate extends ApplicationEvent {
  final String universityId;
  final String universityProgramId;
  final double tuitionFee;
  final String periodId;
  final String? universityApplyCode;
  final String? studentNumber;
  final String? id;

  ApplicationCreate({
    required this.universityId,
    required this.universityProgramId,
    required this.tuitionFee,
    required this.periodId,
    this.universityApplyCode,
    this.studentNumber,
    this.id,
  });
}

class ApplicationDelete extends ApplicationEvent {
  final Application application;

  ApplicationDelete({
    required this.application,
  });
}

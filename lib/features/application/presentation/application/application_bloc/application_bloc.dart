import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/domain/use_cases/create_application.dart';
import 'package:edu_apply/features/application/domain/use_cases/delete_application.dart';
import 'package:edu_apply/features/application/domain/use_cases/get_applications.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final GetApplications _getApplications;
  final CreateApplication _createApplication;
  final DeleteApplication _deleteApplication;

  ApplicationBloc({
    required GetApplications getApplications,
    required CreateApplication createApplication,
    required DeleteApplication deleteApplication,
  })  : _getApplications = getApplications,
        _createApplication = createApplication,
        _deleteApplication = deleteApplication,
        super(ApplicationInitial(applicationList: [])) {
    on<ApplicationFetch>(_handleApplicationFetch);
    on<ApplicationCreate>(_handleApplicationCreate);
    on<ApplicationDelete>(_handleApplicationDelete);
  }

  Future<void> _handleApplicationDelete(
      ApplicationDelete event, Emitter<ApplicationState> emit) async {
    int index = state.applicationList
        .indexWhere((element) => element.id == event.application.id);
    if (index == -1) {
      emit(ApplicationFailure(
          message: "Application not found",
          applicationList: [...state.applicationList]));
    } else {
      Application applicationCopy = state.applicationList.removeAt(index);
      emit(ApplicationSuccess(applicationList: [...state.applicationList]));
      var result = await _deleteApplication
          .call(DeleteApplicationParams(applicationId: event.application.id));
      if (result.isRight()) return;

      state.applicationList.insert(index, applicationCopy);
      result.mapLeft(
        (a) => emit(ApplicationFailure(
            message: a.message, applicationList: [...state.applicationList])),
      );
    }
  }

  Future<void> _handleApplicationFetch(
      ApplicationFetch event, Emitter<ApplicationState> emit) async {
    emit(ApplicationLoading(applicationList: [...state.applicationList]));
    var result = await _getApplications.call(GetApplicationsParams(
      page: event.page,
      size: event.size,
    ));
    result.fold(
      (l) => emit(ApplicationFailure(
          message: l.message, applicationList: [...state.applicationList])),
      (r) => emit(ApplicationSuccess(applicationList: r.content)),
    );
  }

  Future<void> _handleApplicationCreate(
      ApplicationCreate event, Emitter<ApplicationState> emit) async {
    emit(ApplicationLoading(applicationList: [...state.applicationList]));
    var result = await _createApplication.call(
      CreateApplicationParams(
        universityId: event.universityId,
        universityProgramId: event.universityProgramId,
        tuitionFee: event.tuitionFee,
        periodId: event.periodId,
      ),
    );
    result.fold(
      (l) => emit(ApplicationFailure(
          message: l.message, applicationList: [...state.applicationList])),
      (r) => emit(
          ApplicationSuccess(applicationList: [...state.applicationList, r])),
    );
  }
}

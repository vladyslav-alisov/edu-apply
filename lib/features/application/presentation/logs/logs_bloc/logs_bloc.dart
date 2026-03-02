import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';
import 'package:edu_apply/features/application/domain/use_cases/get_logs.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsOverviewState> {
  final GetLogs _getLogs;

  LogsBloc({required GetLogs getLogs})
      : _getLogs = getLogs,
        super(LogsOverviewState()) {
    on<LogsFetch>(_handleLogsFetch);
  }

  Future<void> _handleLogsFetch(LogsFetch event, Emitter<LogsOverviewState> emit) async {
    emit(state.copyWith(status: () => LogsOverviewStatus.loading));
    var result =
        await _getLogs.call(GetLogsParams(applicationId: event.applicationId));
    result.fold(
      (l) => emit(state.copyWith(status: () => LogsOverviewStatus.failure)),
      (r) => emit(state.copyWith(
          status: () => LogsOverviewStatus.success, logs: () => r)),
    );
  }
}

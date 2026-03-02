part of 'logs_bloc.dart';

enum LogsOverviewStatus { initial, loading, success, failure }

@immutable
class LogsOverviewState extends Equatable {
  final List<Log> logs;
  final LogsOverviewStatus status;

  LogsOverviewState copyWith({
    LogsOverviewStatus Function()? status,
    List<Log> Function()? logs,
  }) {
    return LogsOverviewState(
      status: status != null ? status() : this.status,
      logs: logs != null ? logs() : this.logs,
    );
  }

  const LogsOverviewState({
    this.logs = const [],
    this.status = LogsOverviewStatus.initial,
  });

  @override
  List<Object?> get props => [logs, status];
}

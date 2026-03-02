part of 'logs_bloc.dart';

@immutable
sealed class LogsEvent {}

final class LogsFetch extends LogsEvent {
  final String applicationId;

  LogsFetch({required this.applicationId});
}

part of 'application_bloc.dart';

@immutable
sealed class ApplicationState {
  final List<Application> applicationList;

  const ApplicationState({
    required this.applicationList,
  });
}

final class ApplicationInitial extends ApplicationState {
  const ApplicationInitial({required super.applicationList});
}

final class ApplicationLoading extends ApplicationState {
  const ApplicationLoading({required super.applicationList});
}

final class ApplicationFailure extends ApplicationState {
  final String message;

  const ApplicationFailure({
    required this.message,
    required super.applicationList,
  });
}

final class ApplicationSuccess extends ApplicationState {
  const ApplicationSuccess({required super.applicationList});
}

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final Gender sex;
  final String phone;
  final String? usedReferralCode;
  final String? parentAgencyId;
  final String? counsellorId;
  final String? agencyId;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.phone,
    this.usedReferralCode,
    this.parentAgencyId,
    this.counsellorId,
    this.agencyId,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}

final class AuthForgotPassword extends AuthEvent {
  final String email;

  AuthForgotPassword({
    required this.email,
  });
}

final class AuthTryLoginWithToken extends AuthEvent {}

final class AuthProfileLoginFailed extends AuthEvent {
  final String message;

  AuthProfileLoginFailed({required this.message});
}

final class AuthLogout extends AuthEvent {}

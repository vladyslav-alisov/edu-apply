import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/auth/domain/entities/user.dart';
import 'package:edu_apply/features/auth/domain/use_cases/user_forgot_password.dart';
import 'package:edu_apply/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:edu_apply/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:edu_apply/features/auth/domain/use_cases/user_try_login_with_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserForgotPassword _userForgotPassword;
  final UserTryLoginWithToken _userTryLoginWithToken;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserForgotPassword userForgotPassword,
    required UserTryLoginWithToken userTryLoginWithToken,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userForgotPassword = userForgotPassword,
        _userTryLoginWithToken = userTryLoginWithToken,
        super(AuthInitial()) {
    on<AuthForgotPassword>(_handleUserForgotPassword);
    on<AuthSignUp>(_handleSignUp);
    on<AuthLogin>(_handleLogin);
    on<AuthTryLoginWithToken>(_handleTryLoginWithToken);
    on<AuthProfileLoginFailed>(_handleAuthProfileLoginFail);
    on<AuthLogout>(_handleAuthLogout);
  }

  void _handleAuthLogout(AuthLogout event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  void _handleAuthProfileLoginFail(
      AuthProfileLoginFailed event, Emitter<AuthState> emit) {
    emit(AuthFailure(message: event.message));
  }

  Future<void> _handleUserForgotPassword(
      AuthForgotPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userForgotPassword(
      UserForgotPasswordParams(
        email: event.email,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthPasswordSentSuccess()),
    );
  }

  Future<void> _handleTryLoginWithToken(
      AuthTryLoginWithToken event, Emitter<AuthState> emit) async {
    final response = await _userTryLoginWithToken(NoParams());
    response.fold(
      (l) => emit(AuthFailure(message: "")),
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  Future<void> _handleSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        sex: event.sex,
        phone: event.phone,
        agencyId: event.agencyId,
        counsellorId: event.counsellorId,
        parentAgencyId: event.parentAgencyId,
        usedReferralCode: event.usedReferralCode,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  Future<void> _handleLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        if (!r.isVerified) {
          emit(AuthFailure(
              message: "You need to verify your account before proceeding."));
        } else {
          emit(AuthSuccess(user: r));
        }
      },
    );
  }
}

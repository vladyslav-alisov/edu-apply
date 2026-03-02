part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  final Profile? _profile;

  Profile get profile => _profile ?? (throw "Profile not found");
  bool get isProfileInitialized => _profile != null;

  const ProfileState({required Profile? profile}) : _profile = profile;
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({required super.profile});
}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess({required super.profile});
}

final class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess({required super.profile});
}

final class ProfileInitSuccess extends ProfileState {
  const ProfileInitSuccess({required super.profile});
}

final class ProfileUpdateFailure extends ProfileState {
  final String message;

  const ProfileUpdateFailure({
    required this.message,
    required super.profile,
  });
}

final class ProfileInitFailure extends ProfileState {
  final String message;

  const ProfileInitFailure({
    required this.message,
    required super.profile,
  });
}

final class ProfileUpdateLoading extends ProfileSuccess {
  const ProfileUpdateLoading({required super.profile});
}

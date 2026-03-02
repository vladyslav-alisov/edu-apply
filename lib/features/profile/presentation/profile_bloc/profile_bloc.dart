import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/domain/use_cases/delete_document.dart';
import 'package:edu_apply/features/profile/domain/use_cases/profile_fetch.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_contact.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_family.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_language_course.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_passport.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_personal.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_profile_picture.dart';
import 'package:edu_apply/features/profile/domain/use_cases/update_school.dart';
import 'package:edu_apply/features/profile/domain/use_cases/upload_document.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileFetch _profileFetch;
  final UpdateContact _updateContact;
  final UpdateFamily _updateFamily;
  final UpdateLanguageCourse _updateLanguageCourse;
  final UpdatePassport _updatePassport;
  final UpdatePersonal _updatePersonal;
  final UpdateSchool _updateSchool;
  final UploadDocument _uploadDocument;
  final DeleteDocument _deleteDocument;
  final UpdateProfileImage _updateProfileImage;

  ProfileBloc({
    required ProfileFetch profileFetch,
    required UpdateContact updateContact,
    required UpdateFamily updateFamily,
    required UpdateLanguageCourse updateLanguageCourse,
    required UpdatePassport updatePassport,
    required UpdatePersonal updatePersonal,
    required UpdateSchool updateSchool,
    required UploadDocument uploadDocument,
    required DeleteDocument deleteDocument,
    required UpdateProfileImage updateProfileImage,
  })  : _profileFetch = profileFetch,
        _updateContact = updateContact,
        _updateFamily = updateFamily,
        _updateLanguageCourse = updateLanguageCourse,
        _updatePassport = updatePassport,
        _updatePersonal = updatePersonal,
        _updateSchool = updateSchool,
        _uploadDocument = uploadDocument,
        _deleteDocument = deleteDocument,
        _updateProfileImage = updateProfileImage,
        super(ProfileInitial(profile: null)) {
    on<ProfileInitStarted>(_handleProfileInitStarted);
    on<ProfileUpdatePersonal>(_handleProfileUpdatePersonal);
    on<ProfileUpdateLanguageCourse>(_handleProfileUpdateLanguageCourse);
    on<ProfileUpdateSchool>(_handleProfileUpdateSchool);
    on<ProfileUpdatePassport>(_handleProfileUpdatePassport);
    on<ProfileUpdateFamily>(_handleProfileUpdateFamily);
    on<ProfileUpdateContact>(_handleProfileUpdateContact);
    on<ProfileUploadDocument>(_handleProfileUploadDocument);
    on<ProfileDeleteDocument>(_handleDeleteDocument);
    on<ProfileUpdateImage>(_handleProfileUpdateImage);
  }

  Future<void> _handleProfileInitStarted(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    var result = await _profileFetch.call(NoParams());
    result.fold(
      (l) =>
          emit(ProfileInitFailure(profile: state.profile, message: l.message)),
      (r) => emit(ProfileInitSuccess(profile: r)),
    );
  }

  Future<void> _handleDeleteDocument(
      ProfileDeleteDocument event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _deleteDocument.call(
      DeleteDocumentParams(
        id: event.id,
      ),
    );
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUploadDocument(
      ProfileUploadDocument event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _uploadDocument.call(
      UploadDocumentParams(
        documentName: event.documentName,
        document: event.document,
        grade: event.grade,
      ),
    );
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdatePersonal(
      ProfileUpdatePersonal event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _updatePersonal.call(UpdatePersonalParams(
      firstName: event.firstName,
      lastName: event.lastName,
      birthdate: event.birthdate,
      gender: event.gender,
      fatherFirstName: event.fatherFirstName,
      motherFirstName: event.motherFirstName,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdateLanguageCourse(
      ProfileUpdateLanguageCourse event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _updateLanguageCourse.call(UpdateLanguageCourseParams(
      language: event.language,
      examDate: event.examDate,
      grade: event.grade,
      certificate: event.certificate,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdateSchool(
      ProfileUpdateSchool event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));

    var result = await _updateSchool.call(UpdateSchoolParams(
      diploma: event.diploma,
      cgpa: event.cgpa,
      country: event.country,
      degree: event.degree,
      graduationYear: event.graduationYear,
      schoolName: event.schoolName,
      transcript: event.transcript,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdatePassport(
      ProfileUpdatePassport event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));

    var result = await _updatePassport.call(UpdatePassportParams(
      nationality: event.nationality,
      passportNumber: event.passportNumber,
      issueDate: event.issueDate,
      expireDate: event.expireDate,
      passportFile: event.passportFile,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdateFamily(
      ProfileUpdateFamily event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));

    var result = await _updateFamily.call(UpdateFamilyParams(
      fatherFirstName: event.fatherFirstName,
      motherFirstName: event.motherFirstName,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdateContact(
      ProfileUpdateContact event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _updateContact.call(UpdateContactParams(
      mobilePhone: event.mobilePhone,
      email: event.email,
      address: event.address,
      cityOfResidence: event.cityOfResidence,
      countryOfResidence: event.countryOfResidence,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }

  Future<void> _handleProfileUpdateImage(
      ProfileUpdateImage event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading(profile: state.profile));
    var result = await _updateProfileImage.call(UpdateProfileImageParams(
      profileImage: event.profileImage,
    ));
    result.fold(
      (l) => emit(
          ProfileUpdateFailure(message: l.message, profile: state.profile)),
      (r) => emit(ProfileUpdateSuccess(profile: r)),
    );
  }
}

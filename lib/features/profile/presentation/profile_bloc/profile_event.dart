part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileInit extends ProfileEvent {}

class ProfileInitStarted extends ProfileEvent {}

class ProfileUpdateFamily extends ProfileEvent {
  final String? fatherFirstName;
  final String? motherFirstName;

  ProfileUpdateFamily({
    this.fatherFirstName,
    this.motherFirstName,
  });
}

class ProfileUpdateContact extends ProfileEvent {
  final String? mobilePhone;
  final String? email;
  final AvailableCountryCode? countryOfResidence;
  final String? cityOfResidence;
  final String? address;

  ProfileUpdateContact({
    this.mobilePhone,
    this.email,
    this.countryOfResidence,
    this.cityOfResidence,
    this.address,
  });
}

class ProfileUploadDocument extends ProfileEvent {
  final File document;
  final String documentName;
  final String? grade;

  ProfileUploadDocument({
    required this.document,
    required this.documentName,
    this.grade,
  });
}

class ProfileDeleteDocument extends ProfileEvent {
  final String id;

  ProfileDeleteDocument({
    required this.id,
  });
}

class ProfileUpdateLanguageCourse extends ProfileEvent {
  final String? language;
  final DateTime? examDate;
  final String? grade;
  final File? certificate;

  ProfileUpdateLanguageCourse({
    required this.language,
    required this.examDate,
    required this.grade,
    required this.certificate,
  });
}

class ProfileUpdatePassport extends ProfileEvent {
  final AvailableCountryCode? nationality;
  final String? passportNumber;
  final DateTime? issueDate;
  final DateTime? expireDate;
  final File? passportFile;

  ProfileUpdatePassport({
    required this.nationality,
    required this.passportNumber,
    required this.issueDate,
    required this.expireDate,
    required this.passportFile,
  });
}

class ProfileUpdateImage extends ProfileEvent {
  final File profileImage;

  ProfileUpdateImage({
    required this.profileImage,
  });
}

class ProfileUpdateSchool extends ProfileEvent {
  final String? schoolName;
  final String? degree;
  final AvailableCountryCode? country;
  final String? graduationYear;
  final String? cgpa;
  final File? diploma;
  final File? transcript;

  ProfileUpdateSchool({
    this.schoolName,
    this.degree,
    this.country,
    this.graduationYear,
    this.cgpa,
    this.diploma,
    this.transcript,
  });
}

class ProfileUpdatePersonal extends ProfileEvent {
  final String firstName;
  final String lastName;
  final Gender? gender;
  final DateTime? birthdate;
  final String? fatherFirstName;
  final String? motherFirstName;

  ProfileUpdatePersonal({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.birthdate,
    this.fatherFirstName,
    this.motherFirstName,
  });
}

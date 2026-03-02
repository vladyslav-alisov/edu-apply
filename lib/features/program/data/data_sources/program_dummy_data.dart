import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/currency.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/season.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/features/program/data/models/program_application_date_model.dart';
import 'package:edu_apply/features/program/data/models/program_model.dart';
import 'package:edu_apply/features/program/data/models/program_period_model.dart';

// ---------------------------------------------------------------------------
// Helpers to generate varied dummy data
// ---------------------------------------------------------------------------

const _universityNames = [
  'Istanbul Technical University',
  'University of Oxford',
  'Technical University of Munich',
  'Delft University of Technology',
  'Sorbonne University',
  'Massachusetts Institute of Technology',
  'University of Toronto',
  'Politecnico di Milano',
  'University of Barcelona',
  'KTH Royal Institute of Technology',
];

const _universityIds = [
  'uni-001',
  'uni-002',
  'uni-003',
  'uni-004',
  'uni-005',
  'uni-006',
  'uni-007',
  'uni-008',
  'uni-009',
  'uni-010',
];

const _countries = [
  AvailableCountryCode.tr,
  AvailableCountryCode.gb,
  AvailableCountryCode.de,
  AvailableCountryCode.nl,
  AvailableCountryCode.fr,
  AvailableCountryCode.us,
  AvailableCountryCode.ca,
  AvailableCountryCode.it,
  AvailableCountryCode.es,
  AvailableCountryCode.se,
];

const _programNames = [
  'Computer Science',
  'Mechanical Engineering',
  'Business Administration',
  'Electrical Engineering',
  'Data Science',
  'Biomedical Engineering',
  'Architecture',
  'Chemical Engineering',
  'Economics',
  'Mathematics',
  'Physics',
  'Civil Engineering',
  'Psychology',
  'Artificial Intelligence',
  'Environmental Science',
  'Industrial Design',
  'Aerospace Engineering',
  'International Relations',
  'Software Engineering',
  'Philosophy',
];

const _faculties = [
  'Faculty of Engineering',
  'Faculty of Science',
  'Faculty of Business',
  'Faculty of Arts',
  'Faculty of Medicine',
];

const _currencies = [
  Currency.euro,
  Currency.usd,
  Currency.pound,
  Currency.lira
];
const _degreeTypes = DegreeType.values;
const _modesOfStudy = [
  ModeOfStudy.fullTime,
  ModeOfStudy.partTime,
  ModeOfStudy.online
];
const _campusTypes = [CampusType.onCampus, CampusType.offCampus];
const _universityTypes = [UniversityType.state, UniversityType.private];
const _languages = [
  'English',
  'German',
  'French',
  'Turkish',
  'Dutch',
  'Italian',
  'Spanish',
  'Swedish'
];
const _seasons = Season.values;

AttachmentModel _dummyAttachment(String seed) => AttachmentModel(
      id: 'att-$seed',
      url: 'https://picsum.photos/seed/$seed/400/300',
      fileType: 'image/jpeg',
      size: 2048,
    );

ProgramApplicationDateModel _dummyDate(int index) =>
    ProgramApplicationDateModel(
      id: 'date-$index',
      quotaIsFull: false,
      programId: 'prog-${index.toString().padLeft(3, '0')}',
      startDate: DateTime(2026, 3, 1),
      endDate: DateTime(2026, 7, 31),
      period: ProgramPeriodModel(
        id: 'period-$index',
        label: 'Fall 2026',
        year: '2026',
        season: _seasons[index % _seasons.length],
      ),
    );

// ---------------------------------------------------------------------------
// 40 dummy programs
// ---------------------------------------------------------------------------

final List<ProgramModel> dummyPrograms = List<ProgramModel>.generate(40, (i) {
  final uniIndex = i % _universityNames.length;
  final nameIndex = i % _programNames.length;
  final fee = 5000.0 + (i * 750.0);

  return ProgramModel(
    id: 'prog-${i.toString().padLeft(3, '0')}',
    universityId: _universityIds[uniIndex],
    language: _languages[i % _languages.length],
    name: '${_programNames[nameIndex]} ${i >= 20 ? "(Advanced)" : ""}',
    description: 'This is a comprehensive ${_programNames[nameIndex]} program '
        'offered by ${_universityNames[uniIndex]}. '
        'It provides students with in-depth knowledge and hands-on experience.',
    websiteUrl: 'https://example.com/programs/$i',
    category: 'Engineering & Technology',
    faculty: _faculties[i % _faculties.length],
    applicationStartDate: DateTime(2026, 1, 1),
    applicationEndDate: DateTime(2026, 6, 30),
    scope: '240',
    programStartMonth: DateTime(2026, 9),
    dates: [_dummyDate(i)],
    currency: _currencies[i % _currencies.length],
    degreeType: _degreeTypes[i % _degreeTypes.length],
    modeOfStudy: _modesOfStudy[i % _modesOfStudy.length],
    campusType: _campusTypes[i % _campusTypes.length],
    tuitionFee: fee,
    deposit: fee * 0.1,
    image: _dummyAttachment('progImg$i'),
    brochure: null,
    duration: 24 + (i % 4) * 12,
    discountPercentage: i % 5 == 0 ? 10 : null,
    numberOfInstallations: 4,
    siblingDiscountPercentage: 5,
    cashPaymentDiscountPercentage: i % 3 == 0 ? 3 : null,
    universityName: _universityNames[uniIndex],
    universityType: _universityTypes[i % _universityTypes.length],
    universityCountry: _countries[uniIndex],
    maximumCommission: 15.0,
    universityImage: _dummyAttachment('uniImg$uniIndex'),
    universityLogo: _dummyAttachment('uniLogo$uniIndex'),
  );
});

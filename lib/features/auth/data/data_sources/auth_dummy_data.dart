import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/const/enums/user_role.dart';
import 'package:edu_apply/features/auth/data/models/user_model.dart';

final UserModel dummyUser = UserModel(
  id: 'student-001',
  email: 'john.doe@example.com',
  firstName: 'John',
  lastName: 'Doe',
  authProvider: 'email',
  sex: Gender.male,
  role: UserRole.student,
  accessToken: 'dummy-access-token-abc123',
  idToken: 'dummy-id-token-xyz789',
  isVerified: true,
  agencyId: 'agency-001',
  parentAgencyId: 'parent-agency-001',
  counsellorId: 'counsellor-001',
  referrerId: 'referrer-001',
  referralCode: 'REF-JOHNDOE',
  referrerUserRole: UserRole.counsellor,
);

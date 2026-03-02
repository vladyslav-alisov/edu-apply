import 'dart:io';
import 'dart:math';

import 'package:edu_apply/core/common/models/additional_document_model.dart';
import 'package:edu_apply/core/common/models/attachment_model.dart';
import 'package:edu_apply/core/common/models/pageable_model.dart';
import 'package:edu_apply/core/common/models/paginated_response_model.dart';
import 'package:edu_apply/core/common/models/sort_data_model.dart';
import 'package:edu_apply/core/const/enums/application_status.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/currency.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/source.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/features/application/data/data_sources/application_dummy_data.dart';
import 'package:edu_apply/features/application/data/data_sources/application_remote_data_source.dart';
import 'package:edu_apply/features/application/data/data_sources/comment_dummy_data.dart';
import 'package:edu_apply/features/application/data/data_sources/file_dummy_data.dart';
import 'package:edu_apply/features/application/data/data_sources/log_dummy_data.dart';
import 'package:edu_apply/features/application/data/models/application_model.dart';
import 'package:edu_apply/features/application/data/models/comment_model.dart';
import 'package:edu_apply/features/application/data/models/log_model.dart';
import 'package:edu_apply/features/program/data/data_sources/program_dummy_data.dart';
import 'package:edu_apply/features/program/data/data_sources/university_details_dummy_data.dart';
import 'package:edu_apply/features/program/data/models/program_model.dart';
import 'package:edu_apply/features/program/data/models/university_basic_details_model.dart';

class ApplicationRemoteDataSourceDummyImpl
    implements ApplicationRemoteDataSource {
  final List<ApplicationModel> _applications = List.from(dummyApplications);
  final Map<String, List<CommentModel>> _comments = {
    for (final entry in dummyComments.entries)
      entry.key: List.from(entry.value),
  };
  final Map<String, List<LogModel>> _logs = {
    for (final entry in dummyLogs.entries) entry.key: List.from(entry.value),
  };
  final Map<String, List<AdditionalDocumentModel>> _files = {
    for (final entry in dummyApplicationFiles.entries)
      entry.key: List.from(entry.value),
  };

  @override
  Future<PaginatedResponseModel<ApplicationModel>> getApplications({
    int page = 0,
    int size = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final start = page * size;
    final end = min(start + size, _applications.length);
    final pageContent = start < _applications.length
        ? _applications.sublist(start, end)
        : <ApplicationModel>[];
    final totalPages = size > 0 ? (_applications.length / size).ceil() : 1;

    return PaginatedResponseModel<ApplicationModel>(
      content: pageContent,
      pageable: PageableModel(
        pageNumber: page,
        pageSize: size,
        sort: SortDataModel(sorted: false, empty: true, unsorted: true),
        offset: start,
        paged: true,
        unpaged: false,
      ),
      totalPages: totalPages,
      totalElements: _applications.length,
      last: page >= totalPages - 1,
      size: size,
      number: page,
      sort: SortDataModel(sorted: false, empty: true, unsorted: true),
      numberOfElements: pageContent.length,
      first: page == 0,
      empty: pageContent.isEmpty,
    );
  }

  @override
  Future<ApplicationModel> createApplication({
    required String universityId,
    required String universityProgramId,
    required double tuitionFee,
    String? periodId,
    String? universityApplyCode,
    String? studentNumber,
    String? id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Look up program and university from existing dummy data
    final ProgramModel? program =
        dummyPrograms.cast<ProgramModel?>().firstWhere(
              (p) => p!.id == universityProgramId,
              orElse: () => null,
            );
    final UniversityBasicDetailsModel? university = dummyUniversityBasicDetails
        .cast<UniversityBasicDetailsModel?>()
        .firstWhere(
          (u) => u!.id == universityId,
          orElse: () => null,
        );

    final newApp = ApplicationModel(
      id: id ?? 'app-${DateTime.now().millisecondsSinceEpoch}',
      counsellorId: null,
      universityProgramId: universityProgramId,
      universityId: universityId,
      agencyId: 'agency-001',
      parentAgencyId: 'parent-agency-001',
      workerId: 'worker-001',
      studentId: 'student-001',
      periodId: periodId ?? program?.dates.firstOrNull?.period.id ?? '',
      periodLabel: program?.dates.firstOrNull?.period.label ?? 'Fall 2026',
      periodYear: program?.dates.firstOrNull?.period.year ?? '2026',
      code: 'APP-${DateTime.now().millisecondsSinceEpoch}',
      universityProgramName: program?.name ?? 'New Program',
      programStartMonth: program?.programStartMonth ?? DateTime(2026, 9),
      universityName:
          program?.universityName ?? university?.name ?? 'University',
      universityApplyCode: universityApplyCode ?? '',
      agencyName: 'Global Education Agency',
      workerName: 'Sarah Smith',
      studentName: 'John Doe',
      counsellorName: null,
      agencyType: 'PREMIUM',
      educationLanguage: program?.language ?? 'English',
      source: Source.website,
      status: ApplicationStatus.newApplication,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
      tuitionFee: tuitionFee,
      amountPaid: 0,
      amountToPay: tuitionFee,
      discountPercentageGiven: 0,
      degreeType: program?.degreeType ?? DegreeType.bachelorDegree,
      campusType: program?.campusType ?? CampusType.onCampus,
      studentCountry: AvailableCountryCode.us,
      universityType: program?.universityType ?? UniversityType.state,
      lastStatusMessage: null,
      approved: false,
      applied: false,
      tuitionCurrency: program?.currency ?? Currency.usd,
    );

    _applications.add(newApp);
    _comments[newApp.id] = [];
    _logs[newApp.id] = [
      LogModel(
        id: 'log-${DateTime.now().millisecondsSinceEpoch}',
        applicationId: newApp.id,
        createdBy: 'student-001',
        title: 'Application Created',
        message: 'New application submitted.',
        creatorName: 'John Doe',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: ApplicationStatus.newApplication,
        files: [],
      ),
    ];
    _files[newApp.id] = [];

    return newApp;
  }

  @override
  Future<String> deleteApplication({required String applicationId}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _applications.removeWhere((app) => app.id == applicationId);
    _comments.remove(applicationId);
    _logs.remove(applicationId);
    _files.remove(applicationId);
    return applicationId;
  }

  @override
  Future<PaginatedResponseModel<AdditionalDocumentModel>> getFiles({
    required String applicationId,
    int page = 0,
    int size = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final appFiles = _files[applicationId] ?? [];
    final start = page * size;
    final end = min(start + size, appFiles.length);
    final pageContent = start < appFiles.length
        ? appFiles.sublist(start, end)
        : <AdditionalDocumentModel>[];
    final totalPages = size > 0 ? (appFiles.length / size).ceil() : 1;

    return PaginatedResponseModel<AdditionalDocumentModel>(
      content: pageContent,
      pageable: PageableModel(
        pageNumber: page,
        pageSize: size,
        sort: SortDataModel(sorted: false, empty: true, unsorted: true),
        offset: start,
        paged: true,
        unpaged: false,
      ),
      totalPages: totalPages,
      totalElements: appFiles.length,
      last: page >= totalPages - 1,
      size: size,
      number: page,
      sort: SortDataModel(sorted: false, empty: true, unsorted: true),
      numberOfElements: pageContent.length,
      first: page == 0,
      empty: pageContent.isEmpty,
    );
  }

  @override
  Future<AdditionalDocumentModel> addFile({
    required String applicationId,
    required File file,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final newFile = AdditionalDocumentModel(
      id: 'file-${DateTime.now().millisecondsSinceEpoch}',
      studentId: 'student-001',
      file: AttachmentModel(
        id: 'att-file-${DateTime.now().millisecondsSinceEpoch}',
        url: file.path,
        fileType: 'application/pdf',
        size: 2048,
      ),
      name: name,
      grade: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _files.putIfAbsent(applicationId, () => []);
    _files[applicationId]!.add(newFile);

    return newFile;
  }

  @override
  Future<List<CommentModel>> getComments({
    required String applicationId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _comments[applicationId] ?? [];
  }

  @override
  Future<CommentModel> createComment({
    required String applicationId,
    required String text,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final newComment = CommentModel(
      id: 'comment-${DateTime.now().millisecondsSinceEpoch}',
      createdBy: 'student-001',
      text: text,
      creatorName: 'John Doe',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _comments.putIfAbsent(applicationId, () => []);
    _comments[applicationId]!.add(newComment);

    return newComment;
  }

  @override
  Future<List<LogModel>> getLogs({required String applicationId}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _logs[applicationId] ?? [];
  }
}

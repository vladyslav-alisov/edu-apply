import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/core/const/enums/available_language.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/program_duration.dart';
import 'package:edu_apply/core/const/enums/program_sort_type.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';
import 'package:edu_apply/features/program/domain/use_cases/get_programs.dart';

part 'program_event.dart';
part 'program_state.dart';

ProgramState initState = ProgramState(
  status: ProgramStateStatus.initLoading,
  programList: [],
  message: '',
  totalElements: 0,
  currentPage: 0,
  isLastPage: false,
);

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final GetPrograms _getPrograms;

  ProgramBloc({required GetPrograms getPrograms})
      : _getPrograms = getPrograms,
        super(initState) {
    on<ProgramSearchPrograms>(_handleSearchPrograms);
    on<ProgramSearchProgramsMore>(_handleSearchProgramsMore);
  }

  Future<void> _handleSearchPrograms(
      ProgramSearchPrograms event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(status: ProgramStateStatus.fetchLoading));
    var response = await _getPrograms(
      GetProgramsParams(
        name: event.name.isEmpty ? null : event.name,
        countryCode: event.countryCode,
        city: event.city,
        university: event.university?.map((e) => e.id).toList(),
        degreeType: event.degreeType,
        campusType: event.campusType,
        universityType: event.universityType,
        modeOfStudy: event.modeOfStudy,
        language: event.language,
        maxFee: event.maxFee,
        minFee: event.minFee,
        durationInMonths: event.durationInMonths,
        sortType: event.sortType,
      ),
    );
    response.fold(
      (l) => emit(state.copyWith(
        message: l.message,
        status: ProgramStateStatus.failure,
      )),
      (r) => emit(state.copyWith(
        status: ProgramStateStatus.success,
        isLastPage: r.last,
        currentPage: r.number,
        totalElements: r.totalElements,
        programList: r.content,
      )),
    );
  }

  Future<void> _handleSearchProgramsMore(
      ProgramSearchProgramsMore event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(status: ProgramStateStatus.fetchMoreLoading));
    var response = await _getPrograms(GetProgramsParams(
      page: event.page,
      name: event.name.isEmpty ? null : event.name,
      countryCode: event.countryCode,
      city: event.city,
      university: event.university?.map((e) => e.id).toList(),
      degreeType: event.degreeType,
      campusType: event.campusType,
      universityType: event.universityType,
      modeOfStudy: event.modeOfStudy,
      language: event.language,
      maxFee: event.maxFee,
      minFee: event.minFee,
      durationInMonths: event.durationInMonths,
      sortType: event.sortType,
    ));
    response.fold(
      (l) => emit(state.copyWith(
        message: l.message,
        status: ProgramStateStatus.failure,
      )),
      (r) => emit(state.copyWith(
        status: ProgramStateStatus.success,
        isLastPage: r.last,
        currentPage: r.number,
        totalElements: r.totalElements,
        programList: [...state.programList, ...r.content],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/const/enums/available_language.dart';
import 'package:edu_apply/core/const/enums/campus_type.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';
import 'package:edu_apply/core/const/enums/mode_of_study.dart';
import 'package:edu_apply/core/const/enums/program_duration.dart';
import 'package:edu_apply/core/const/enums/program_sort_type.dart';
import 'package:edu_apply/core/const/enums/university_type.dart';
import 'package:edu_apply/core/utils/translatable.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/widgets/country_filter_section.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/widgets/enum_filter_section.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/widgets/labeled_filter_section.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/widgets/sort_filter_section.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/widgets/university_filter_section.dart';

class FilterCriteriaState {
  final List<AvailableCountryCode>? countryFilter;
  final List<UniversityBasicDetails>? universitiesFilter;
  final List<UniversityType>? universityTypeFilter;
  final List<DegreeType>? degreeTypeFilter;
  final List<ModeOfStudy>? modeOfStudyFilter;
  final List<CampusType>? campusTypeFilter;
  final List<ProgramDuration>? durationFilter;
  final List<AvailableLanguage>? languageListFilter;
  final double? minFeeFilter;
  final double? maxFeeFilter;
  final ProgramSortType? programTypeSort;

  const FilterCriteriaState({
    this.countryFilter,
    this.universitiesFilter,
    this.universityTypeFilter,
    this.degreeTypeFilter,
    this.modeOfStudyFilter,
    this.campusTypeFilter,
    this.durationFilter,
    this.languageListFilter,
    this.minFeeFilter,
    this.maxFeeFilter,
    this.programTypeSort,
  });

  int get nFiltersOn {
    int i = 0;
    if (countryFilter != null) i++;
    if (universitiesFilter != null) i++;
    if (universityTypeFilter != null) i++;
    if (degreeTypeFilter != null) i++;
    if (modeOfStudyFilter != null) i++;
    if (campusTypeFilter != null) i++;
    if (durationFilter != null) i++;
    if (languageListFilter != null) i++;
    if (minFeeFilter != null) i++;
    if (maxFeeFilter != null) i++;
    if (programTypeSort != null) i++;
    return i;
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required FilterCriteriaState filterCurrentState,
  }) : _filterCriteriaState = filterCurrentState;

  final FilterCriteriaState _filterCriteriaState;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<AvailableCountryCode> _selectedCountryFilter;
  late List<UniversityBasicDetails> _selectedUniversitiesFilter;
  late List<UniversityType> _selectedUniversityTypeFilter;
  late List<DegreeType> _selectedDegreeTypeFilter;
  late List<ModeOfStudy> _selectedModeOfStudyFilter;
  late List<CampusType> _selectedCampusTypeFilter;
  late List<ProgramDuration> _selectedDurationFilter;
  late List<AvailableLanguage> _selectedLanguageListFilter;
  late TextEditingController _selectedMinFeeFilter;
  late TextEditingController _selectedMaxFeeFilter;
  late ProgramSortType _selectedProgramTypeSort;

  @override
  void initState() {
    super.initState();
    _selectedCountryFilter = widget._filterCriteriaState.countryFilter ?? [];
    _selectedUniversitiesFilter =
        widget._filterCriteriaState.universitiesFilter ?? [];
    _selectedUniversityTypeFilter =
        widget._filterCriteriaState.universityTypeFilter ?? [];
    _selectedDegreeTypeFilter =
        widget._filterCriteriaState.degreeTypeFilter ?? [];
    _selectedModeOfStudyFilter =
        widget._filterCriteriaState.modeOfStudyFilter ?? [];
    _selectedCampusTypeFilter =
        widget._filterCriteriaState.campusTypeFilter ?? [];
    _selectedDurationFilter = widget._filterCriteriaState.durationFilter ?? [];
    _selectedLanguageListFilter =
        widget._filterCriteriaState.languageListFilter ?? [];
    _selectedMinFeeFilter = TextEditingController(
        text: widget._filterCriteriaState.minFeeFilter?.toString() ?? "");
    _selectedMaxFeeFilter = TextEditingController(
        text: widget._filterCriteriaState.maxFeeFilter?.toString() ?? "");
    _selectedProgramTypeSort = widget._filterCriteriaState.programTypeSort ??
        ProgramSortType.suggested;
  }

  @override
  void dispose() {
    _selectedMinFeeFilter.dispose();
    _selectedMaxFeeFilter.dispose();
    super.dispose();
  }

  bool get _isInitState {
    bool isInitState = _selectedCountryFilter.isEmpty &&
        _selectedUniversitiesFilter.isEmpty &&
        _selectedUniversityTypeFilter.isEmpty &&
        _selectedDegreeTypeFilter.isEmpty &&
        _selectedModeOfStudyFilter.isEmpty &&
        _selectedCampusTypeFilter.isEmpty &&
        _selectedDurationFilter.isEmpty &&
        _selectedLanguageListFilter.isEmpty &&
        _selectedMinFeeFilter.text.isEmpty &&
        _selectedMaxFeeFilter.text.isEmpty &&
        _selectedProgramTypeSort == ProgramSortType.suggested;

    return isInitState;
  }

  void _onApplyPress() {
    FilterCriteriaState newState = FilterCriteriaState(
      countryFilter:
          _selectedCountryFilter.isEmpty ? null : _selectedCountryFilter,
      universitiesFilter: _selectedUniversitiesFilter.isEmpty
          ? null
          : _selectedUniversitiesFilter,
      universityTypeFilter: _selectedUniversityTypeFilter.isEmpty
          ? null
          : _selectedUniversityTypeFilter,
      degreeTypeFilter:
          _selectedDegreeTypeFilter.isEmpty ? null : _selectedDegreeTypeFilter,
      modeOfStudyFilter: _selectedModeOfStudyFilter.isEmpty
          ? null
          : _selectedModeOfStudyFilter,
      campusTypeFilter:
          _selectedCampusTypeFilter.isEmpty ? null : _selectedCampusTypeFilter,
      durationFilter:
          _selectedDurationFilter.isEmpty ? null : _selectedDurationFilter,
      languageListFilter: _selectedLanguageListFilter.isEmpty
          ? null
          : _selectedLanguageListFilter,
      maxFeeFilter: _selectedMaxFeeFilter.text.isEmpty
          ? null
          : double.tryParse(_selectedMaxFeeFilter.text),
      minFeeFilter: _selectedMinFeeFilter.text.isEmpty
          ? null
          : double.tryParse(_selectedMinFeeFilter.text),
      programTypeSort: _selectedProgramTypeSort == ProgramSortType.suggested
          ? null
          : _selectedProgramTypeSort,
    );
    context.pop(newState);
  }

  void _onResetPress() {
    FilterCriteriaState newState = FilterCriteriaState();
    context.pop(newState);
  }

  void _onSortTypeChanged(ProgramSortType sortType) {
    _selectedProgramTypeSort = sortType;
  }

  void _onCountrySelected(AvailableCountryCode selectedCountry) {
    _selectedCountryFilter.add(selectedCountry);
  }

  void _onCountryUnSelected(AvailableCountryCode removedCountry) {
    _selectedCountryFilter.removeWhere((element) => element == removedCountry);
  }

  void _onUniversitySelected(UniversityBasicDetails selectedUniversity) {
    _selectedUniversitiesFilter.add(selectedUniversity);
  }

  void _onUniversityUnSelected(UniversityBasicDetails removedUniversity) {
    _selectedUniversitiesFilter
        .removeWhere((element) => element == removedUniversity);
  }

  void _onEnumRemoved(Translatable translatableEnum) {
    if (translatableEnum is ModeOfStudy) {
      _selectedModeOfStudyFilter
          .removeWhere((element) => element == translatableEnum);
    } else if (translatableEnum is CampusType) {
      _selectedCampusTypeFilter
          .removeWhere((element) => element == translatableEnum);
    } else if (translatableEnum is DegreeType) {
      _selectedDegreeTypeFilter
          .removeWhere((element) => element == translatableEnum);
    } else if (translatableEnum is UniversityType) {
      _selectedUniversityTypeFilter
          .removeWhere((element) => element == translatableEnum);
    } else if (translatableEnum is ProgramDuration) {
      _selectedDurationFilter
          .removeWhere((element) => element == translatableEnum);
    } else if (translatableEnum is AvailableLanguage) {
      _selectedLanguageListFilter
          .removeWhere((element) => element == translatableEnum);
    }
  }

  void _onEnumSelected(Translatable translatableEnum) {
    if (translatableEnum is ModeOfStudy) {
      _selectedModeOfStudyFilter.add(translatableEnum);
    }
    if (translatableEnum is CampusType) {
      _selectedCampusTypeFilter.add(translatableEnum);
    }
    if (translatableEnum is DegreeType) {
      _selectedDegreeTypeFilter.add(translatableEnum);
    }
    if (translatableEnum is UniversityType) {
      _selectedUniversityTypeFilter.add(translatableEnum);
    }
    if (translatableEnum is ProgramDuration) {
      _selectedDurationFilter.add(translatableEnum);
    }
    if (translatableEnum is AvailableLanguage) {
      _selectedLanguageListFilter.add(translatableEnum);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ElevatedButton(
              onPressed: _onApplyPress,
              child: Text(
                "Apply",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Filter",
          style: theme.textTheme.headlineSmall,
        ),
        actions: !_isInitState
            ? [
                TextButton(
                  onPressed: _onResetPress,
                  child: Text(
                    "Clear all",
                  ),
                ),
              ]
            : null,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widgetInserter(
                children: [
                  LabeledFilterSection(
                    title: "Sort",
                    child: SortFilterSection(
                      initSortingType: _selectedProgramTypeSort,
                      onSortTypeChanged: _onSortTypeChanged,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Degree type",
                    child: EnumFilterSection<DegreeType>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: DegreeType.values,
                      initList: _selectedDegreeTypeFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Campus type",
                    child: EnumFilterSection<CampusType>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: CampusType.values,
                      initList: _selectedCampusTypeFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Duration",
                    child: EnumFilterSection<ProgramDuration>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: ProgramDuration.values,
                      initList: _selectedDurationFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Language",
                    child: EnumFilterSection<AvailableLanguage>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: AvailableLanguage.values,
                      initList: _selectedLanguageListFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Study mode",
                    child: EnumFilterSection<ModeOfStudy>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: ModeOfStudy.values,
                      initList: _selectedModeOfStudyFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "University type",
                    child: EnumFilterSection<UniversityType>(
                      onSelected: _onEnumSelected,
                      onRemoved: _onEnumRemoved,
                      availableValues: UniversityType.values,
                      initList: _selectedUniversityTypeFilter,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Country",
                    child: CountryFilterSection(
                      initCountryList: _selectedCountryFilter,
                      onCountrySelected: _onCountrySelected,
                      onCountryUnselected: _onCountryUnSelected,
                    ),
                  ),
                  LabeledFilterSection(
                    title: "Universities",
                    child: UniversityFilterSection(
                      initUniversityList: _selectedUniversitiesFilter,
                      onUniversitySelected: _onUniversitySelected,
                      onUniversityUnselected: _onUniversityUnSelected,
                    ),
                  ),
                ],
                separator: Divider(
                  thickness: 1,
                  height: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

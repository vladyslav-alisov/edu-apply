import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/program/domain/entities/university_basic_details.dart';
import 'package:edu_apply/features/program/domain/use_cases/get_university_basic_details.dart';
import 'package:edu_apply/init_dependencies.main.dart';

class UniversityFilterSection extends StatefulWidget {
  const UniversityFilterSection({
    super.key,
    required this.initUniversityList,
    required this.onUniversitySelected,
    required this.onUniversityUnselected,
  });

  final List<UniversityBasicDetails> initUniversityList;
  final ValueChanged<UniversityBasicDetails> onUniversitySelected;
  final ValueChanged<UniversityBasicDetails> onUniversityUnselected;

  @override
  State<UniversityFilterSection> createState() =>
      _UniversityFilterSectionState();
}

class _UniversityFilterSectionState extends State<UniversityFilterSection> {
  late List<UniversityBasicDetails> _selectedUniversity;
  late List<UniversityBasicDetails> _availableUniversities;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedUniversity = List.from(widget.initUniversityList);
    _availableUniversities = [];
    _initData();
  }

  void _initData() async {
    _isLoading = true;
    final getProgram = serviceLocator<GetUniversityBasicDetails>();
    final universityBasicDetails = await getProgram.call(NoParams());
    universityBasicDetails.fold(
      (l) => debugPrint(l.message),
      (r) => _availableUniversities.addAll(r),
    );
    setState(() => _isLoading = false);
  }

  void _onSelect(UniversityBasicDetails selectedUniversity) {
    setState(() => _selectedUniversity.add(selectedUniversity));
    widget.onUniversitySelected(selectedUniversity);
  }

  void _onUnselect(UniversityBasicDetails removedUniversity, int index) {
    setState(() => _selectedUniversity.removeAt(index));
    widget.onUniversityUnselected(removedUniversity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: StyledLoadingIndicator(),
            ),
          )
        : Wrap(
            spacing: 12,
            children: List.generate(
              _availableUniversities.length,
              (index) {
                bool isSelected = _selectedUniversity.indexWhere((element) =>
                        _availableUniversities[index].id == element.id) !=
                    -1;
                return FilterChip(
                  onSelected: (isSelected) {
                    UniversityBasicDetails university =
                        _availableUniversities[index];
                    int tempIndex = _selectedUniversity
                        .indexWhere((element) => element == university);

                    bool isAlreadyIncluded = tempIndex != -1;

                    if (isSelected && !isAlreadyIncluded) _onSelect(university);
                    if (!isSelected && isAlreadyIncluded) {
                      _onUnselect(university, tempIndex);
                    }
                  },
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  selectedColor: Color(0xFFF0FBFF),
                  label: Text(
                    _availableUniversities[index].name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isSelected ? theme.primaryColor : null,
                    ),
                  ),
                  selected: isSelected,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: theme.primaryColor,
                      width: 1,
                    ),
                  ),
                );
              },
            ),
          );
  }
}

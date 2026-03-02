import 'package:flutter/material.dart';
import 'package:edu_apply/core/const/enums/program_sort_type.dart';

class SortFilterSection extends StatefulWidget {
  const SortFilterSection({
    super.key,
    required this.initSortingType,
    required this.onSortTypeChanged,
  });

  final ProgramSortType initSortingType;
  final ValueChanged<ProgramSortType> onSortTypeChanged;

  @override
  State<SortFilterSection> createState() => _SortFilterSectionState();
}

class _SortFilterSectionState extends State<SortFilterSection> {
  late ProgramSortType _selectedSortType;

  @override
  void initState() {
    super.initState();
    _selectedSortType = widget.initSortingType;
  }

  void _onSelectSortType(ProgramSortType newSortType) {
    setState(() => _selectedSortType = newSortType);
    widget.onSortTypeChanged(newSortType);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      children: List.generate(
        ProgramSortType.values.length,
        (index) {
          List<ProgramSortType> values = ProgramSortType.values;
          bool isSelected = _selectedSortType == values[index];
          return ChoiceChip(
            onSelected: (value) {
              if (value) _onSelectSortType(values[index]);
            },
            showCheckmark: false,
            backgroundColor: Colors.white,
            selectedColor: Color(0xFFF0FBFF),
            label: Text(
              values[index].getTitle(context),
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

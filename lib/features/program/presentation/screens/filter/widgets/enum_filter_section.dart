import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

class EnumFilterSection<T extends Translatable> extends StatefulWidget {
  const EnumFilterSection({
    super.key,
    required this.initList,
    required this.onSelected,
    required this.onRemoved,
    required this.availableValues,
  });

  final List<T> initList;
  final ValueChanged<T> onSelected;
  final ValueChanged<T> onRemoved;
  final List<T> availableValues;

  @override
  State<EnumFilterSection> createState() => _EnumFilterSectionState<T>();
}

class _EnumFilterSectionState<T extends Translatable>
    extends State<EnumFilterSection<T>> {
  late List<T> _selectedElements;
  late List<T> _availableElements;

  @override
  void initState() {
    super.initState();
    _selectedElements = List.from(widget.initList);
    _availableElements = widget.availableValues;
  }

  void _onSelect(T newCampusType) {
    setState(() => _selectedElements.add(newCampusType));
    widget.onSelected(newCampusType);
  }

  void _onUnselect(T removedCampusType, int index) {
    setState(() => _selectedElements.removeAt(index));
    widget.onRemoved(removedCampusType);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      children: List.generate(
        _availableElements.length,
        (index) {
          bool isSelected =
              _selectedElements.contains(_availableElements[index]);
          return FilterChip(
            onSelected: (isSelected) {
              T degreeType = _availableElements[index];
              int tempIndex = _selectedElements
                  .indexWhere((element) => element == degreeType);

              bool isAlreadyIncluded = tempIndex != -1;

              if (isSelected && !isAlreadyIncluded) _onSelect(degreeType);
              if (!isSelected && isAlreadyIncluded) {
                _onUnselect(degreeType, tempIndex);
              }
            },
            showCheckmark: false,
            backgroundColor: Colors.white,
            selectedColor: Color(0xFFF0FBFF),
            label: Text(
              _availableElements[index].getTitle(context),
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

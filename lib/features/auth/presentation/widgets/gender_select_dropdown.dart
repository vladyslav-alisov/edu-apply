import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/const/enums/gender.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';

class GenderSelectDropdown extends StatefulWidget {
  const GenderSelectDropdown({
    super.key,
    required Gender initGender,
    required ValueChanged<Gender> onValueChanged,
  })  : _initGender = initGender,
        _onValueChanged = onValueChanged;

  final Gender _initGender;
  final ValueChanged<Gender> _onValueChanged;

  @override
  State<GenderSelectDropdown> createState() => _GenderSelectDropdownState();
}

class _GenderSelectDropdownState extends State<GenderSelectDropdown> {
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget._initGender;
  }

  void _onGenderChange(Gender? newGender) {
    if (newGender != null) {
      widget._onValueChanged(newGender);
      setState(() => _selectedGender = newGender);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.gender,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(12),
        DropdownButtonFormField<Gender>(
          initialValue: _selectedGender,
          items: Gender.values
              .map((Gender item) => DropdownMenuItem<Gender>(
                    value: item,
                    child: Text(
                      item.getDescription(context),
                    ),
                  ))
              .toList(),
          onChanged: _onGenderChange,
        ),
      ],
    );
  }
}

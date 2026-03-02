import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/const/enums/country_code.dart';
import 'package:edu_apply/core/use_case/use_case.dart';
import 'package:edu_apply/features/program/domain/use_cases/get_countries.dart';
import 'package:edu_apply/init_dependencies.main.dart';

class CountryFilterSection extends StatefulWidget {
  const CountryFilterSection({
    super.key,
    required this.initCountryList,
    required this.onCountrySelected,
    required this.onCountryUnselected,
  });

  final List<AvailableCountryCode> initCountryList;
  final ValueChanged<AvailableCountryCode> onCountrySelected;
  final ValueChanged<AvailableCountryCode> onCountryUnselected;

  @override
  State<CountryFilterSection> createState() => _CountryFilterSectionState();
}

class _CountryFilterSectionState extends State<CountryFilterSection> {
  late List<AvailableCountryCode> _selectedCounties;
  late List<AvailableCountryCode> _availableCountries;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedCounties = List.from(widget.initCountryList);
    _availableCountries = [];
    _initData();
  }

  void _initData() async {
    _isLoading = true;

    final getCountries = serviceLocator<GetCountries>();
    final countriesList = await getCountries.call(NoParams());
    countriesList.fold(
      (l) => debugPrint(l.message),
      (r) => _availableCountries.addAll(r),
    );
    setState(() => _isLoading = false);
  }

  void _onSelect(AvailableCountryCode newCountry) {
    setState(() => _selectedCounties.add(newCountry));
    widget.onCountrySelected(newCountry);
  }

  void _onUnselect(AvailableCountryCode removedCountry, int index) {
    setState(() => _selectedCounties.removeAt(index));
    widget.onCountryUnselected(removedCountry);
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
              _availableCountries.length,
              (index) {
                bool isSelected =
                    _selectedCounties.contains(_availableCountries[index]);
                return FilterChip(
                  onSelected: (isSelected) {
                    AvailableCountryCode country = _availableCountries[index];
                    int tempIndex = _selectedCounties
                        .indexWhere((element) => element == country);

                    bool isAlreadyIncluded = tempIndex != -1;

                    if (isSelected && !isAlreadyIncluded) _onSelect(country);
                    if (!isSelected && isAlreadyIncluded) {
                      _onUnselect(country, tempIndex);
                    }
                  },
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  selectedColor: Color(0xFFF0FBFF),
                  label: Text(
                    _availableCountries[index].countryName,
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

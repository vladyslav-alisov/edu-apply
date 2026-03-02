import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/const/enums/degree_type.dart';

class UniversityListTile extends StatelessWidget {
  const UniversityListTile({
    super.key,
    required String universityName,
    required String universityLogoUrl,
    required DegreeType degreeType,
    required String programName,
  })  : _universityName = universityName,
        _universityLogoUrl = universityLogoUrl,
        _degreeType = degreeType,
        _programName = programName;

  final String _universityName;
  final String _universityLogoUrl;
  final DegreeType _degreeType;
  final String _programName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
          child: Image.network(
            _universityLogoUrl,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) => SizedBox(
              width: 80,
              height: 80,
              child: Icon(Icons.error_outline),
            ),
          ),
        ),
        Gap(10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _degreeType.getTitle(context),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Gap(4),
              Text(
                _programName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gap(4),
              Text(
                _universityName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

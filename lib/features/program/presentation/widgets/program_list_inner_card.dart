import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/presentation/widgets/program_list_card.dart';
import 'package:edu_apply/features/program/presentation/widgets/university_list_tile.dart';

class ProgramSummaryCard extends StatelessWidget {
  const ProgramSummaryCard({
    super.key,
    required Program program,
    required ValueChanged<Program> onCardTap,
    required void Function(Program) onApplyTap,
  })  : _onApplyTap = onApplyTap,
        _program = program,
        _onCardTap = onCardTap;

  final Program _program;
  final ValueChanged<Program> _onCardTap;
  final ValueChanged<Program> _onApplyTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCardTap(_program),
      child: StyledContainer(
        child: Column(
          children: [
            UniversityListTile(
              universityName: _program.universityName,
              universityLogoUrl: _program.universityLogo.url,
              degreeType: _program.degreeType,
              programName: _program.name,
            ),
            Gap(10),
            ProgramListCard(
              onApplyPressed: () => _onApplyTap(_program),
              language: _program.language,
              modeOfStudy: _program.modeOfStudy,
              campusType: _program.campusType,
              programStartMonth: _program.programStartMonth,
              currency: _program.currency,
              tuitionFee: _program.tuitionFee,
            ),
          ],
        ),
      ),
    );
  }
}

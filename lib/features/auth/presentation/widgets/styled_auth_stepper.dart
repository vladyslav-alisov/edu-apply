import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';

enum SignUpStep {
  personalInfo,
  password;

  String stepDescription(BuildContext context) {
    return switch (this) {
      SignUpStep.personalInfo => context.l10n.nextStepPassword,
      SignUpStep.password => context.l10n.previousStepPersonalInformation,
    };
  }

  String stepTitle(BuildContext context) {
    return switch (this) {
      SignUpStep.personalInfo => context.l10n.personalInformation,
      SignUpStep.password => context.l10n.password,
    };
  }
}

class StyledAuthStepper extends StatelessWidget {
  const StyledAuthStepper({
    super.key,
    required SignUpStep signUpStep,
  }) : _signUpStep = signUpStep;

  final SignUpStep _signUpStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularPercentIndicator(
          radius: 30.0,
          lineWidth: 4.0,
          percent: _signUpStep == SignUpStep.personalInfo ? 0.5 : 1,
          center: Text(
            _signUpStep == SignUpStep.personalInfo ? "1/2" : "2/2",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          progressColor: Theme.of(context).primaryColor,
        ),
        const Gap(12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _signUpStep.stepTitle(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                _signUpStep.stepDescription(context),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}

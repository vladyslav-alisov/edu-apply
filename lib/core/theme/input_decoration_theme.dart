import 'package:flutter/material.dart';
import 'package:edu_apply/core/theme/color_scheme.dart';
import 'package:edu_apply/core/theme/text_theme.dart';

const double kBorderRadius = 10;

final inputDecorationThemeLight = InputDecorationTheme(
  errorMaxLines: 2,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 0,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: BorderSide.none,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: BorderSide.none,
  ),
  filled: true,
);

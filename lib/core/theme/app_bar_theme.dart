import 'package:flutter/material.dart';
import 'package:edu_apply/core/theme/text_theme.dart';

final appBarTheme = AppBarTheme(
  centerTitle: true,
  titleTextStyle: lightTextTheme.headlineLarge?.copyWith(color: Colors.black),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  elevation: 0.2,
);

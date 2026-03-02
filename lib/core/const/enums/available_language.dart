import 'package:flutter/material.dart';
import 'package:edu_apply/core/utils/translatable.dart';

enum AvailableLanguage implements Translatable {
  english("english"),
  turkish("turkish");

  const AvailableLanguage(this.json);

  final String json;
  @override
  String getTitle(BuildContext context) {
    return switch (this) {
      AvailableLanguage.english => "English",
      AvailableLanguage.turkish => "Turkish",
    };
  }
}

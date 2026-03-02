import 'package:flutter/cupertino.dart';

enum Gender {
  male("MALE"),
  female("FEMALE");

  final String json;

  const Gender(this.json);

  String getDescription(BuildContext context) => switch (this) {
        Gender.male => "Male",
        Gender.female => "Female",
      };
}

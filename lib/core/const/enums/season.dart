import 'package:flutter/material.dart';

enum Season {
  spring("SPRING"),
  summer("SUMMER"),
  fall("FALL"),
  winter("WINTER");

  final String json;

  String getTitle(BuildContext context) => switch (this) {
        Season.spring => "Spring",
        Season.summer => "Summer",
        Season.fall => "Fall",
        Season.winter => "Winter",
      };

  const Season(this.json);
}

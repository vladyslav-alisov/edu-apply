import 'package:flutter/material.dart';
import 'package:edu_apply/core/const/assets.gen.dart';

class AppBarImage extends StatelessWidget {
  const AppBarImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.logoAppbar.path,
      width: 90,
      height: 40,
    );
  }
}

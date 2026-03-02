import 'package:flutter/material.dart';

class StyledScrollableNoDataWidget extends StatelessWidget {
  const StyledScrollableNoDataWidget({super.key, this.content});

  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          child: Align(
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ],
    );
  }
}

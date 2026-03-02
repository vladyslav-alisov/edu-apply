import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';

class StyledFullScreenLoading extends StatefulWidget {
  const StyledFullScreenLoading({super.key});

  @override
  State<StyledFullScreenLoading> createState() =>
      _StyledFullScreenLoadingState();
}

class _StyledFullScreenLoadingState extends State<StyledFullScreenLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: StyledLoadingIndicator(),
      ),
    );
  }
}

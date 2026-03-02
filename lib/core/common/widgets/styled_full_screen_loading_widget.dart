import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/widgets/styled_full_screen_loading.dart';

class StyledFullScreenLoadingWidget extends StatelessWidget {
  const StyledFullScreenLoadingWidget({
    super.key,
    required Widget child,
    required bool isLoading,
  })  : _isLoading = isLoading,
        _child = child;

  final Widget _child;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _child,
        if (_isLoading) const StyledFullScreenLoading(),
      ],
    );
  }
}

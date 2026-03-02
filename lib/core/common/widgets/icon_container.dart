import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required Widget child,
    EdgeInsetsGeometry? padding,
  })  : _child = child,
        _padding = padding;

  final Widget _child;
  final EdgeInsetsGeometry? _padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding ?? EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: _child,
    );
  }
}

import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  const StyledContainer({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.borderColor,
  });

  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 0.75,
          color: borderColor ?? Theme.of(context).colorScheme.outline,
        ),
      ),
      child: child,
    );
  }
}

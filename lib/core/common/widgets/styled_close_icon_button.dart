import 'package:flutter/material.dart';

class StyledCloseIconButton extends StatelessWidget {
  const StyledCloseIconButton({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.close,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

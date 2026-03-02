import 'package:flutter/material.dart';

Iterable<Widget> widgetInserter({
  required List<Widget> children,
  required Widget separator,
}) {
  return children.isEmpty
      ? []
      : List.generate(
          children.length * 2 - 1, // for n items, (2n - 1) elements are needed
          (index) {
            if (index.isEven) {
              // For even indexes, return the item widget
              int actualIndex = index ~/ 2; // integer division
              return children[actualIndex];
            } else {
              // For odd indexes, return the divider or custom widget
              return separator;
            }
          },
        );
}

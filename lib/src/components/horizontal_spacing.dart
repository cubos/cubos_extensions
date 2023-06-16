import 'package:flutter/material.dart';

/// A box with a specific width, with no children.
///
/// Used to create horizontal space between components, replacing the
/// using [SizedBox(width: 20.0)] and reducing the number of lines of code.
/// {@tool snippet}
///
/// ```dart
/// const HorizontalSpacing(20.0);
/// ```
/// {@end-tool}
class HorizontalSpacing extends StatelessWidget {
  final double width;

  const HorizontalSpacing(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

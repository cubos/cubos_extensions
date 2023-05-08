import 'package:flutter/material.dart';

/// A box with a specific height, with no children.
///
/// Used to create vertical space between components, replacing the
/// using [SizedBox(height: 20.0)] and reducing the number of lines of code.
/// {@tool snippet}
///
/// ```dart
/// const VerticalSpacing(20.0);
/// ```
/// {@end-tool}
class VerticalSpacing extends StatelessWidget {
  final double height;

  const VerticalSpacing(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

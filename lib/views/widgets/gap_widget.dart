import 'package:flutter/material.dart';

class GapWidget extends StatelessWidget {
  final double size;
  const GapWidget({super.key, this.size = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15 + size,
      height: 15 + size,
    );
  }
}
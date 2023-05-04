import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphismWidget extends StatelessWidget {
  const GlassMorphismWidget({super.key, required this.child});
  
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: ColoredBox(
          color: Colors.white.withAlpha(40),
          child: child,
        ),
      ),
    );
}

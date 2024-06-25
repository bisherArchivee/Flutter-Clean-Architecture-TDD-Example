import 'package:flutter/material.dart';

class AppScrollConfiguration extends StatelessWidget {
  const AppScrollConfiguration({
    required this.child,
    this.behavior,
    super.key,
  });

  final Widget child;
  final ScrollBehavior? behavior;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: behavior ?? const ScrollBehavior(),
      child: AppGlowingOverscrollIndicator(child: child),
    );
  }
}

class AppGlowingOverscrollIndicator extends StatelessWidget {
  const AppGlowingOverscrollIndicator({
    required this.child,
    this.axisDirection = AxisDirection.down,
    this.showLeading = false,
    this.showTrailing = false,
    this.color = Colors.transparent,
    super.key,
  });

  final Widget child;
  final AxisDirection axisDirection;
  final bool showLeading;
  final bool showTrailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      child: child,
      axisDirection: axisDirection,
      showLeading: showLeading,
      showTrailing: showTrailing,
      color: color,
    );
  }
}

import 'package:flutter/material.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({
    String? mediaResImage,
    required Widget child,
    super.key,
  })  : _mediaResImage = mediaResImage,
        _child = child;

  final String? _mediaResImage;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: _mediaResImage != null
            ? DecorationImage(
                image: AssetImage(_mediaResImage!),
                fit: BoxFit.cover,
              )
            : null,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            if (themeBrightness == Brightness.light)
              Colors.yellow.withOpacity(0.8)
            else
              Colors.yellow.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(child: Center(child: _child)),
    );
  }
}

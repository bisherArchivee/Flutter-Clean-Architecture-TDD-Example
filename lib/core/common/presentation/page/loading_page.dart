import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.themeEXT.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

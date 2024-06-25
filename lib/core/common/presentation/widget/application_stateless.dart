import 'package:flutter/material.dart';

class ApplicationStatelessWidget extends StatelessWidget {
  const ApplicationStatelessWidget({super.key});

  // You can add common configurations or methods here

  @override
  Widget build(BuildContext context) {
    // Common UI components can be added here
    return Container(
      // Common container styling
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    // Subclasses should override this method
    throw UnimplementedError('buildBody must be implemented by subclasses');
  }
}
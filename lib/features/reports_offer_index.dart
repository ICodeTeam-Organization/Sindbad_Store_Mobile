import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';

class ViewReportsScreen extends StatelessWidget {
  const ViewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: CustomAppBar(
          tital: 'التقارير',
          isBack: false,
        ),
      ),
    );
  }
}

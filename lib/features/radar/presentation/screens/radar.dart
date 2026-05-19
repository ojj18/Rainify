import 'package:flutter/material.dart';

import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../../../../core/common/widgets/under_construction_widget.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnderConstructionWidget(),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}

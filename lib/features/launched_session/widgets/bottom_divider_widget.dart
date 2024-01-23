import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';

class BottomDivider extends StatelessWidget {
  const BottomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: dividerThickness);
  }
}

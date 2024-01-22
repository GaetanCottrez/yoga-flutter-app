import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.42,
      right: size.width * 0.15,
      child: FloatingActionButton(
        onPressed: () {},
        elevation: 5.0,
        backgroundColor: primary,
        child: const Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
    );
  }
}

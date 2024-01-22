import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

class NextPoseText extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;

  const NextPoseText({
    Key? key,
    required this.poses,
    required this.poseIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          "Suivant: ${poseIndex >= poses.length - 1 ? "Terminer" : poses[poseIndex].english_name}",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: white),
        ),
      ),
    );
  }
}

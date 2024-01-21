import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/breaktime_screen.dart';

class NavigationControls extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  NavigationControls({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (poseIndex != 0)
            NavigationButton(
              text: "Précédent",
              onPressed: () => navigateToPose(context, false),
            ),
          if (poseIndex != poses.length - 1)
            NavigationButton(
              text: "Suivant",
              onPressed: () => navigateToPose(context, true),
            ),
        ],
      ),
    );
  }

  void navigateToPose(BuildContext context, bool isNext) async {
    final timerModel =
        Provider.of<BreaktimeTimerModelSec>(context, listen: false);
    timerModel.Pass();

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BreakTimeScreen(
          courseId: courseId,
          courseName: courseName,
          poses: poses,
          poseIndex: isNext ? poseIndex + 1 : poseIndex - 1,
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  NavigationButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/breaktime_screen.dart';

import 'navigation_controls_widget.dart';
import 'pause_widget.dart';
import 'workout_widget.dart';

class BreakTimeWidget extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  BreakTimeWidget({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Stack(
        children: [
          BreakTimeContent(
            poses: poses,
            poseIndex: poseIndex,
            courseName: courseName,
            courseId: courseId,
          ),
          Consumer<BreaktimeTimerModelSec>(
            builder: (context, myModel, child) {
              return PauseOverlay(
                isVisible: myModel.visible,
                onRestart: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkOut(
                        poses: poses,
                        poseIndex: 0,
                        courseId: courseId,
                        courseName: courseName,
                      ),
                    ),
                  );
                },
                onQuit: () => Navigator.pop(context),
                onContinue: myModel.hide,
              );
            },
          ),
        ],
      ),
    );
  }
}

class BreakTimeContent extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  const BreakTimeContent({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const BreakTimeText(),
          BreakTimeCountdown(),
          const SizedBox(height: 20),
          SkipButton(),
          const Spacer(),
          NavigationControls(
            poses: poses,
            poseIndex: poseIndex,
            courseName: courseName,
            courseId: courseId,
          ),
          const BottomDivider(),
          NextPoseText(poses: poses, poseIndex: poseIndex),
        ],
      ),
    );
  }
}

class BreakTimeText extends StatelessWidget {
  const BreakTimeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Break Time",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: white,
      ),
    );
  }
}

class BreakTimeCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BreaktimeTimerModelSec>(
      builder: (context, myModel, child) {
        return Text(
          myModel.countdown.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 65,
            color: white,
          ),
        );
      },
    );
  }
}

class SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BreaktimeTimerModelSec>(
      builder: (context, myModel, child) {
        return ElevatedButton(
          onPressed: myModel.skip,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              "Sauter",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}

class BottomDivider extends StatelessWidget {
  const BottomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 2);
  }
}

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

// Use already defined PauseOverlay widget (see previous response).

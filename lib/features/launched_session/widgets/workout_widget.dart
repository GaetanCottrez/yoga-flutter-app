import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/domain/use-cases/stop_launched_session.dart';
import 'package:yoga_training_app/features/launched_session/pages/breaktime_screen.dart';
import 'package:yoga_training_app/features/launched_session/pages/workout_screen.dart';
import 'package:yoga_training_app/features/launched_session/widgets/pause_widget.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

import 'bottom_divider_widget.dart';
import 'next_pose_widget.dart';

class WorkOutWidget extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  const WorkOutWidget({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workOutModel =
        Provider.of<WorkOutTimerModelSec>(context, listen: false);
    if (workOutModel.isDisposed) {
      return Container(); // ou tout autre widget de remplacement approprié
    }

    return Scaffold(
      body: Stack(
        children: [
          PoseContent(
              poses: poses,
              poseIndex: poseIndex,
              courseId: courseId,
              courseName: courseName),
          PauseOverlayConsumer(
            poses: poses,
            poseIndex: poseIndex,
            courseId: courseId,
            courseName: courseName,
          ),
        ],
      ),
    );
  }
}

class PoseContent extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  const PoseContent({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(poses[poseIndex].img_url_jpg),
        const Spacer(),
        PoseName(poses: poses, poseIndex: poseIndex),
        const Spacer(),
        const CountdownTimer(),
        const SizedBox(height: 30),
        const PauseButton(),
        const Spacer(),
        _buildNavigationButtons(context),
        const BottomDivider(),
        NextPoseText(poses: poses, poseIndex: poseIndex),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (poseIndex != 0)
            Consumer<WorkOutTimerModelSec>(
              builder: (context, myModel, child) {
                return ElevatedButton(
                  onPressed: () async {
                    myModel.Pass();
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreakTimeScreen(
                          courseId: courseId,
                          courseName: courseName,
                          poses: poses,
                          poseIndex: poseIndex - 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: const Text(
                      "Précédent",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
          if (poseIndex != poses.length - 1)
            Consumer<WorkOutTimerModelSec>(
              builder: (context, myModel, child) {
                return ElevatedButton(
                  onPressed: () async {
                    myModel.Pass();
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreakTimeScreen(
                          courseId: courseId,
                          courseName: courseName,
                          poses: poses,
                          poseIndex: poseIndex + 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: const Text(
                      "Suivant",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimerText(),
          Text(" : ", style: timerTextStyle),
          CountdownText(),
        ],
      ),
    );
  }
}

const timerTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: white,
);

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("00", style: timerTextStyle);
  }
}

class CountdownText extends StatelessWidget {
  const CountdownText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutTimerModelSec>(
      builder: (context, myModel, child) {
        String countdownStr = myModel.countdown.toString().padLeft(2, '0');
        return Text(countdownStr, style: timerTextStyle);
      },
    );
  }
}

class PoseName extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;

  const PoseName({
    Key? key,
    required this.poses,
    required this.poseIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        poses[poseIndex].english_name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class NavigationWorkOut extends StatelessWidget {
  const NavigationWorkOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutTimerModelSec>(
      builder: (context, myModel, child) {
        return ElevatedButton(
          onPressed: myModel.show,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text("Pause", style: TextStyle(fontSize: 20)),
          ),
        );
      },
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutTimerModelSec>(
      builder: (context, myModel, child) {
        return ElevatedButton(
          onPressed: myModel.show,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text("Pause", style: TextStyle(fontSize: 20)),
          ),
        );
      },
    );
  }
}

class PauseOverlayConsumer extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final int courseId;
  final String courseName;

  PauseOverlayConsumer({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseId,
    required this.courseName,
  }) : super(key: key);

  final StopLaunchedSessionUseCase stopLaunchedSessionUseCase =
      InjectionContainer.provideStopLaunchedSessionUseCase();

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutTimerModelSec>(
      builder: (context, myModel, child) {
        return PauseOverlay(
          isVisible: myModel.visible,
          onRestart: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WorkOutScreen(
                  poses: poses,
                  poseIndex: 0,
                  courseId: courseId,
                  courseName: courseName,
                ),
              ),
            );
          },
          onQuit: () async {
            await stopLaunchedSessionUseCase.call(courseId);
            Provider.of<WorkOutTimerModelSec>(context, listen: false).dispose();
            Navigator.pop(context);
          },
          onContinue: myModel.hide,
        );
      },
    );
  }
}

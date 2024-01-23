import 'package:flutter/material.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/use-cases/start_launched_session.dart';
import 'package:yoga_training_app/features/launched_session/provider/tips.provider.dart';
import 'package:yoga_training_app/features/launched_session/widgets/bottom_divider_widget.dart';
import 'package:yoga_training_app/features/launched_session/widgets/tip_section_widget.dart';
import 'package:yoga_training_app/features/launched_session/widgets/workout_widget.dart';

class LaunchedSessionWidget extends StatelessWidget {
  final Course course;
  final StartLaunchedSessionUseCase startLaunchedSessionUseCase;
  final TipsProvider tipsProvider;

  const LaunchedSessionWidget({
    Key? key,
    required this.course,
    required this.startLaunchedSessionUseCase,
    required this.tipsProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2), // Replaces the previous SizedBox
            FutureBuilder<LaunchedSession>(
              future: startLaunchedSessionUseCase.call(course.id),
              builder: (context, snapshot) =>
                  LaunchSessionBuilder.build(context, snapshot),
            ),
            const SizedBox(height: 40),
            const CountdownTimer(),
            const Spacer(),
            const BottomDivider(),
            TipSection(tip: tipsProvider.getRandomTip()),
          ],
        ),
      ),
    );
  }
}

class LaunchSessionBuilder {
  // Encapsulates widget building logic based on Future
  static Widget build(
      BuildContext context, AsyncSnapshot<LaunchedSession> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return const Text(
      "ETES-VOUS PRET ?",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/use-cases/stop_launched_session.dart';
import 'package:yoga_training_app/features/home/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/launched_session/widgets/finish_widget.dart';
import 'package:yoga_training_app/injections/course.injection.dart';
import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

class FinishScreen extends StatefulWidget {
  final String courseName;
  final int courseId;

  const FinishScreen({
    Key? key,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  _FinishScreenState createState() =>
      _FinishScreenState(courseName: courseName, courseId: courseId);
}

class _FinishScreenState extends State<FinishScreen> {
  String courseName;
  int courseId;

  _FinishScreenState({
    required this.courseName,
    required this.courseId,
  });

  StopLaunchedSessionUseCase stopLaunchedSessionUseCase =
      InjectionContainer.provideStopLaunchedSessionUseCase();

  @override
  Widget build(BuildContext context) {
    int selectedIconIndex = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            FutureBuilder<LaunchedSession>(
              future: stopLaunchedSessionUseCase.call(courseId),
              // Call the use case.
              builder: (BuildContext context,
                  AsyncSnapshot<LaunchedSession> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return FinishWidget(
                  courseName: courseName,
                  courseId: courseId,
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBarBuilder(
        selectedIndex: selectedIconIndex,
        indexChanged: (int) {},
      ),
    );
  }
}

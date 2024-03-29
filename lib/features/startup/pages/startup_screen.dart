import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/features/home/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/startup//widgets/startup_course.dart';
import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

class StartupScreen extends StatefulWidget {
  final Course course;

  const StartupScreen({Key? key, required this.course}) : super(key: key);

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  int selectedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    printInternal(widget.course.name);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            StartupCourse(widget.course),
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

import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_launched_session.dart';
import 'package:yoga_training_app/domain/use-cases/stop_launched_session.dart';
import 'package:yoga_training_app/features/home/widgets/beginner/beginners_list_widget.dart';
import 'package:yoga_training_app/features/home/widgets/courses/courses_list_widget.dart';
import 'package:yoga_training_app/features/home/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/launched_session/pages/launched_session_screen.dart';
import 'package:yoga_training_app/injections/course.injection.dart';
import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetAllCoursesUseCase getAllCoursesUseCase =
      InjectionContainer.provideGetAllCoursesUseCase();

  GetBeginnerCoursesUseCase getBeginnerCoursesUseCase =
      InjectionContainer.provideGetBeginnerCoursesUseCase();

  GetLaunchedSessionUseCase getLaunchedSessionUseCase =
      InjectionContainer.provideGetLaunchedSessionUseCase();

  StopLaunchedSessionUseCase stopLaunchedSessionUseCase =
      InjectionContainer.provideStopLaunchedSessionUseCase();

  int selectedIconIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            BeginnersList(
              getBeginnerCoursesUseCase: getBeginnerCoursesUseCase,
            ),
            FutureBuilder<LaunchedSession?>(
              future: getLaunchedSessionUseCase.call(), // Call the use case.
              builder: (BuildContext context,
                  AsyncSnapshot<LaunchedSession?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  _maybeShowDialog(snapshot.data);
                }
                return CoursesList(getAllCoursesUseCase: getAllCoursesUseCase);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBarBuilder(
        selectedIndex: selectedIconIndex,
        indexChanged: (int) {},
      ),
    );
  }

  void _maybeShowDialog(LaunchedSession? launchedSession) {
    printInternal('_maybeShowDialog');
    printInternal(launchedSession?.session);
    if (launchedSession?.session != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Session en cours'),
              content: Text(
                'Vous avez la session ${launchedSession?.session?.name} en cours.\n\nVoulez-vous la reprendre ?',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Oui'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LaunchedSessionScreen(
                                course: launchedSession!.session as Course)));
                  },
                ),
                TextButton(
                  child: const Text('Non'),
                  onPressed: () async {
                    await stopLaunchedSessionUseCase
                        .call(launchedSession!.session!.id);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }
}

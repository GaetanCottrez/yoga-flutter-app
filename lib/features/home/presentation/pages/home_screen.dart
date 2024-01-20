import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_launched_session.dart';
import 'package:yoga_training_app/domain/use-cases/stop_launched_session.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/beginners.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/courses.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/launchedSession.dart';
import 'package:yoga_training_app/injections/course.injection.dart';
import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

class HomeScreen extends StatefulWidget {
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
        padding: EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            Beginners(
              getBeginnerCoursesUseCase: getBeginnerCoursesUseCase,
            ),
            FutureBuilder<LaunchedSession?>(
              future: getLaunchedSessionUseCase.call(), // Call the use case.
              builder: (BuildContext context,
                  AsyncSnapshot<LaunchedSession?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  _maybeShowDialog(snapshot.data);
                }
                return Courses(getAllCoursesUseCase: getAllCoursesUseCase);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBarBuilder(
        selectedIndex: selectedIconIndex,
        onNavigationTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
      ),
    );
  }

  void _maybeShowDialog(LaunchedSession? launchedSession) {
    if (launchedSession?.session != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Session en cours'),
              content: Text(
                'Vous avez la session ${launchedSession?.session?.name} en cours.\n\nVoulez-vous la reprendre ?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Oui'),
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
                  child: Text('Non'),
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

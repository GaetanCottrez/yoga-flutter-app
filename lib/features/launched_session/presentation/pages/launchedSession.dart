import 'dart:async';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/config/constant_config.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/domain/use-cases/start_launched_session.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/workout_widget.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

class LaunchedSessionScreen extends StatelessWidget {
  Course course;

  LaunchedSessionScreen({required this.course});

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  var list = [
    'Créez un espace confortable pour votre pratique du yoga.',
    'Le yoga peut atténuer les symptômes de l\'arthrite.',
    'Le yoga est bénéfique pour la santé cardiaque.',
    'Le yoga vous détend pour vous aider à mieux dormir.',
    'Le yoga peut signifier plus d\'énergie et des humeurs plus joyeuses.',
    'Le yoga vous aide à gérer le stress.',
    'Le yoga améliore la posture et la flexibilité.',
    'Pratiquer le yoga contribue à renforcer les muscles.',
    'Le yoga soutient la gestion du poids et le métabolisme.',
    'La méditation et le yoga aident à la clarté mentale.',
    'Le yoga peut réduire l\'anxiété et diminuer les tensions.',
    'La respiration profonde en yoga augmente la capacité pulmonaire.',
    'Les postures de yoga développent l\'équilibre et la coordination.',
    'Le yoga soutient la santé digestive grâce à des postures spécifiques.',
    'La pratique régulière du yoga contribue à un meilleur contrôle des émotions.',
    'Le yoga peut améliorer votre relation avec votre corps et renforcer la confiance en soi.'
  ];

  StartLaunchedSessionUseCase startLaunchedSessionUseCase =
      InjectionContainer.provideStartLaunchedSessionUseCase();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context, course: course),
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                ),
                FutureBuilder<LaunchedSession>(
                  future: startLaunchedSessionUseCase.call(course.id),
                  // Call the use case.
                  builder: (BuildContext context,
                      AsyncSnapshot<LaunchedSession> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return Text(
                      "ETES-VOUS PRET ?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<TimerModel>(builder: (context, myModel, child) {
                  return Text(
                    myModel.countdown.toString(),
                    style: TextStyle(fontSize: 48),
                  );
                }),
                Spacer(),
                Divider(
                  thickness: 2,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        "Tip: " + getRandomElement(list),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  Course course;

  TimerModel(context, {required this.course}) {
    List<Pose> poses =
        Course.MakeThisSession(this.course, ConstantConfig().durationPose);
    MyTimer(context, poses);
  }

  int countdown = 5;

  MyTimer(context, List<Pose> poses) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown == 0) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOut(
                      poses: poses,
                      courseName: course.name,
                      courseId: course.id,
                      poseIndex: 0,
                    )));
      }
      notifyListeners();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/features/launched_session/pages/launched_session_screen.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchedSessionTimerModel>(
      builder: (context, timerModel, child) {
        return Text(
          timerModel.countdown.toString(),
          style: const TextStyle(fontSize: 48),
        );
      },
    );
  }
}

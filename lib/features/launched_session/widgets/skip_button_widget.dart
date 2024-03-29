import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/features/launched_session/pages/breaktime_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

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

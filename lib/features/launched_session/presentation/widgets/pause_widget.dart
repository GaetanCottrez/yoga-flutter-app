import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/constants/constants.dart';

class PauseOverlay extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onRestart;
  final VoidCallback onQuit;
  final VoidCallback onContinue;

  const PauseOverlay({
    Key? key,
    required this.isVisible,
    required this.onRestart,
    required this.onQuit,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        color: primary.withOpacity(0.9),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PauseText(text: "Pause", fontSize: 40),
            const SizedBox(height: 10),
            const PauseText(text: "Yoga feels better", fontSize: 13),
            const SizedBox(height: 30),
            _buildButton("Redémarrer", onRestart),
            _buildButton("Quitter", onQuit),
            _buildButton("Continuer", onContinue, isFilled: true),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {bool isFilled = false}) {
    return OutlinedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: 180,
        child: Text(
          text,
          style: TextStyle(color: isFilled ? primary : white),
          textAlign: TextAlign.center,
        ),
      ),
      style: isFilled
          ? ButtonStyle(backgroundColor: MaterialStateProperty.all(white))
          : ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(color: white))),
    );
  }
}

class PauseText extends StatelessWidget {
  final String text;
  final double fontSize;

  const PauseText({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

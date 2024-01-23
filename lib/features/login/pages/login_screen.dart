import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/login/widgets/background_image_clipper.dart';
import 'package:yoga_training_app/features/login/widgets/circle_button.dart';
import 'package:yoga_training_app/features/login/widgets/login_credentials.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackgroundImage(),
                LoginCredentials(),
              ],
            ),
            const CircleButton(),
          ],
        ),
      ),
    );
  }
}

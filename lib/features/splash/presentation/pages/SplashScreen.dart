import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:restart_app/restart_app.dart';
import 'package:yoga_training_app/core/config/environment_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/features/home/presentation/pages/home_screen.dart';
import 'package:yoga_training_app/features/login/presentation/pages/login_screen.dart';
import 'package:yoga_training_app/repositories/token.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TokenStorage _tokenStorage = TokenStorage();

  checkUp() async {
    try {
      Response response = await get(Uri.parse(EnvironmentConfig.getBaseUrl()));

      if (response.statusCode != 200) {
        var snackBar = SnackBar(
          content: const Text(
              'Notre API est actuellement indisponible. Veuillez réessayer plus tard'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 3000),
          action: SnackBarAction(
            label: "Ok",
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            onPressed: () {
              Restart.restartApp();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      return true;
    } catch (e) {
      var snackBar = SnackBar(
        content: const Text(
            'Une erreur inconnue est survenue. Veuillez réessayer plus tard'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 30000),
        action: SnackBarAction(
          label: "Ok",
          disabledTextColor: Colors.white,
          textColor: Colors.white,
          onPressed: () {
            Restart.restartApp();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUp().then((value) {
      printInternal(value);
      if (value == true) {
        loadScreen(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/logo/yoga_transparent.png")),
    );
  }

  void loadScreen(BuildContext context) async {
    var accessToken = await _tokenStorage.getAccessToken();

    printInternal(accessToken != '' && !JwtDecoder.isExpired(accessToken));
    printInternal(
        accessToken != '' ? JwtDecoder.decode(accessToken) : 'no token');
    if (accessToken != '' && !JwtDecoder.isExpired(accessToken)) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/features/home/presentation/pages/home_screen.dart';
import 'package:yoga_training_app/config/environment_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/features/login/data/repositories/token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginCredentials extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TokenStorage _tokenStorage = TokenStorage();

  Future<String?> login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse(EnvironmentConfig.getBaseUrl() + 'auth/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        printInternal(data['access_token']);
        printInternal('Login successfully');
        printInternal(JwtDecoder.decode(data['access_token']));
        printInternal(JwtDecoder.isExpired(data['access_token']));
        await _tokenStorage.setAccessToken(data['access_token']);
        return data['access_token'];
      } else {
        printInternal('failed');
        return null;
      }
    } catch (e) {
      printInternal(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connectez-vous',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75, horizontal: appPadding),
                fillColor: white,
                hintText: 'Nom d\'utilisateur',
                suffixIcon: Icon(
                  Icons.person,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75, horizontal: appPadding),
                fillColor: Colors.white,
                hintText: 'Mot de passe',
                suffixIcon: Icon(
                  Icons.lock_outline,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Center(
            child: Text(
              'Mot de passe oublié ?',
              style: TextStyle(fontSize: 18, color: black.withOpacity(0.4)),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          InkWell(
              child: GestureDetector(
            onTap: () async {
              var result = await login(usernameController.text.toString(),
                  passwordController.text.toString());
              printInternal(result?.length);
              if (result != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                var snackBar = SnackBar(
                  content: Text('Nom d\'utilisateur ou mot de passe incorrect'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 3000),
                  action: SnackBarAction(
                    label: "J'ai compris !",
                    disabledTextColor: Colors.white,
                    textColor: Colors.white,
                    onPressed: () {
                      //Do whatever you want
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Material(
                elevation: 10.0,
                shadowColor: primary,
                color: primary,
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  width: size.width,
                  height: size.width * 0.15,
                  child: Center(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          )),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yoga_training_app/bootstrap-app.dart';
import 'package:yoga_training_app/core/config/environment_config.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/repositories/token.dart';

class LoginCredentials extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TokenStorage _tokenStorage = TokenStorage();

  LoginCredentials({Key? key}) : super(key: key);

  Future<String?> login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('${EnvironmentConfig.getBaseUrl()}auth/login'),
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
          const Text(
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
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(
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
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => instanceHomeScreen));
              } else {
                var snackBar = SnackBar(
                  content: const Text(
                      'Nom d\'utilisateur ou mot de passe incorrect'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 3000),
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
                child: SizedBox(
                  width: size.width,
                  height: size.width * 0.15,
                  child: const Center(
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

import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/login/presentation/pages/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'core/log/print.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/login/data/repositories/token.dart';

class MyApp extends StatelessWidget {
  final TokenStorage _tokenStorage = TokenStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _tokenStorage.getAccessToken(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          printInternal('snapshot');
          printInternal(
              snapshot.data != '' && !JwtDecoder.isExpired(snapshot.data!));
          printInternal(snapshot.data != ''
              ? JwtDecoder.decode(snapshot.data!)
              : 'no token');
          if (snapshot.data != '' && !JwtDecoder.isExpired(snapshot.data!)) {
            return MaterialApp(
              title: 'Yoga App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: HomeScreen(),
            );
          } else {
            return MaterialApp(
              title: 'Yoga App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginScreen(),
            );
          }
        });
  }
}

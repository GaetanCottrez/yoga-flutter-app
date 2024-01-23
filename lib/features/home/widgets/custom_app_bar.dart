import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/repositories/token.dart';

class CustomAppBar extends StatelessWidget {
  final TokenStorage _tokenStorage = TokenStorage();

  CustomAppBar({Key? key}) : super(key: key);

  Future<String?> getName(BuildContext context) async {
    String accessToken = await _tokenStorage.getAccessToken();
    return JwtDecoder.decode(accessToken)['username'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<String?>(
      future: getName(context),
      builder: (context, snapshot) {
        String name = snapshot.data ?? 'Guest';
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [buildBack(context)],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(appPadding / 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(appPadding / 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(appPadding / 8),
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/propic.jpeg',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  buildBack(BuildContext context) {
    if (!ModalRoute.of(context)!.isFirst) {
      return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 30.0,
          ));
    }
    return const Text(
      'Namaste !',
      style: TextStyle(color: black, fontWeight: FontWeight.w600, fontSize: 18),
    );
  }
}

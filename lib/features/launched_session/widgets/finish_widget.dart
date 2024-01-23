import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/pages/home_screen.dart';

import 'bottom_divider_widget.dart';

class FinishWidget extends StatelessWidget {
  final String courseName;
  final int courseId;

  const FinishWidget({
    Key? key,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 20.0),
        children: [
          Image.network(
            "https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY=",
            width: 350,
            height: 350,
          ),
          Text(
            "Vous avez terminé avec succès la session $courseName",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const BottomDivider(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                "Retour à l'accueil",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

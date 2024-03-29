import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';

class CurvedNavigationBarBuilder extends StatelessWidget {
  final int selectedIndex;
  final Function(int) indexChanged;

  const CurvedNavigationBarBuilder({
    Key? key,
    required this.selectedIndex,
    required this.indexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: selectedIndex,
      buttonBackgroundColor: primary,
      height: 60.0,
      color: white,
      onTap: (index) {
        indexChanged(index); // Handler pour le changement d'index
        _handleNavigationTap(
            context, index); // Appel de la fonction de navigation
      },
      animationDuration: const Duration(
        milliseconds: 200,
      ),
      items: const <Widget>[
        Icon(Icons.play_arrow_outlined, size: 30, color: black),
        Icon(Icons.search, size: 30, color: black),
        Icon(Icons.home_outlined, size: 30, color: black),
        Icon(Icons.query_stats, size: 30, color: black),
        Icon(Icons.person_outline, size: 30, color: black),
      ],
    );
  }

  void _handleNavigationTap(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(
            context, '/search'); // Remplacez par votre route pour search
        break;
      case 2:
        Navigator.pushNamed(context, '/home');
        break;
      case 3:
        Navigator.pushNamed(context, '/stats');
        break;
      case 4:
        /*Navigator.pushNamed(
            context, '/profile');*/
        break;
    }
  }
}

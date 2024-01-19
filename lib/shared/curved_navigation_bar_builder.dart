import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:yoga_training_app/core/constants/constants.dart';

class CurvedNavigationBarBuilder extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavigationTap;

  const CurvedNavigationBarBuilder({
    Key? key,
    required this.selectedIndex,
    required this.onNavigationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: selectedIndex,
      buttonBackgroundColor: primary,
      height: 60.0,
      color: white,
      onTap: onNavigationTap,
      animationDuration: Duration(
        milliseconds: 200,
      ),
      items: <Widget>[
        Icon(
          Icons.play_arrow_outlined,
          size: 30,
          color: selectedIndex == 0 ? white : black,
        ),
        Icon(
          Icons.search,
          size: 30,
          color: selectedIndex == 1 ? white : black,
        ),
        Icon(
          Icons.home_outlined,
          size: 30,
          color: selectedIndex == 2 ? white : black,
        ),
        Icon(
          Icons.favorite_border_outlined,
          size: 30,
          color: selectedIndex == 3 ? white : black,
        ),
        Icon(
          Icons.person_outline,
          size: 30,
          color: selectedIndex == 4 ? white : black,
        ),
      ],
    );
  }
}

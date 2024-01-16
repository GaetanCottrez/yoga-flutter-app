import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/features/home/data/models/pose.dart';
import 'package:yoga_training_app/features/startup/presentation/widgets/details_pose.dart';

class DetailsPoseScreen extends StatefulWidget {
  final Pose pose;

  const DetailsPoseScreen({required this.pose});

  @override
  _DetailsPoseScreenState createState() => _DetailsPoseScreenState();
}

class _DetailsPoseScreenState extends State<DetailsPoseScreen> {
  int selectedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    printInternal(widget.pose.english_name);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            DetailsPose(widget.pose),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIconIndex,
        buttonBackgroundColor: primary,
        height: 60.0,
        color: white,
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
        animationDuration: Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.play_arrow_outlined,
            size: 30,
            color: selectedIconIndex == 0 ? white : black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: selectedIconIndex == 1 ? white : black,
          ),
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIconIndex == 2 ? white : black,
          ),
          Icon(
            Icons.favorite_border_outlined,
            size: 30,
            color: selectedIconIndex == 3 ? white : black,
          ),
          Icon(
            Icons.person_outline,
            size: 30,
            color: selectedIconIndex == 4 ? white : black,
          ),
        ],
      ),
    );
  }
}
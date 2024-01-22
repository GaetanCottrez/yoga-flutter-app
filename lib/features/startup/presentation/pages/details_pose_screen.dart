import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/startup/presentation/widgets/details_pose.dart';
import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

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
      bottomNavigationBar: CurvedNavigationBarBuilder(
        selectedIndex: selectedIconIndex,
        indexChanged: (int) {},
      ),
    );
  }
}

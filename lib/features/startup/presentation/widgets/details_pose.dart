import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

class DetailsPose extends StatelessWidget {
  final Pose _pose;

  DetailsPose(this._pose);

  Future<Pose> getPose() async {
    return _pose;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayText(_pose.english_name),
          displayTextSanskrit(_pose.sanskrit_name),
          displayPoseImg(),
          displaySection('Description'),
          displayLongText(_pose.description),
          displaySection('Benefits'),
          displayLongText(_pose.benefits),
        ],
      ),
    );
  }

  Padding displayLongText(String value) {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: appPadding, vertical: 10),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.5,
          ),
        ));
  }

  Padding displayPoseImg() {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: appPadding, vertical: 5),
        child: Center(child: Image.network(_pose.img_url_jpg, width: 250)));
  }

  Padding displayText(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Padding displaySection(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Padding displayTextSanskrit(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.abc,
            color: black.withOpacity(0.3),
          ),
          Text(value,
              style: TextStyle(
                color: black.withOpacity(0.3),
              ),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

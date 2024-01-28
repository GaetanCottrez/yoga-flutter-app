import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/statistics.dart';

class PoseCard extends StatelessWidget {
  final StatsDataPose pose;
  final double width;
  final double height;

  const PoseCard({
    Key? key,
    required this.pose,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: appPadding * 3, bottom: appPadding * 2),
          width: width * 0.4,
          height: height * 0.2,
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topRight: Radius.circular(100.0),
            ),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.3),
                blurRadius: 20.0,
                offset: const Offset(5, 15),
              ),
            ],
          ),
          child: PoseInfo(pose: pose),
        ),
        PoseThumbnail(
            imageUrl: pose.imgUrlJpg, width: width * 0.2, height: height * 0.2),
      ],
    );
  }
}

class PoseInfo extends StatelessWidget {
  final StatsDataPose pose;

  const PoseInfo({
    Key? key,
    required this.pose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: appPadding / 2, right: appPadding * 3, top: appPadding),
          child: Text(
            pose.englishName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

class PoseThumbnail extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const PoseThumbnail({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: height / 3, // Adjust the top value as needed
      child: Image.network(imageUrl, width: width, height: height),
    );
  }
}

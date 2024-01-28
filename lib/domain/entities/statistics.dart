class StatsData {
  final int totalLaunchedSessionCount;
  final int averageSessionDuration;
  final List<StatsDataPose> mostPracticedPoses;

  StatsData({
    required this.totalLaunchedSessionCount,
    required this.averageSessionDuration,
    required this.mostPracticedPoses,
  });

  factory StatsData.fromJson(Map<String, dynamic> json) => StatsData(
        totalLaunchedSessionCount: json['totalLaunchedSessionCount'],
        averageSessionDuration: json['averageSessionDuration'],
        mostPracticedPoses: List<StatsDataPose>.from(
            json['mostPracticedPoses'].map((x) => StatsDataPose.fromJson(x))),
      );
}

class StatsDataPose {
  final int id;
  final String sanskritName;
  final String englishName;
  final String imgUrlSvg;
  final String imgUrlJpg;
  final String imgUrlSvgAlt;
  final int poseCount;

  StatsDataPose({
    required this.id,
    required this.sanskritName,
    required this.englishName,
    required this.imgUrlSvg,
    required this.imgUrlJpg,
    required this.imgUrlSvgAlt,
    required this.poseCount,
  });

  factory StatsDataPose.fromJson(Map<String, dynamic> json) => StatsDataPose(
        id: json['id'],
        sanskritName: json['sanskrit_name'],
        englishName: json['english_name'],
        imgUrlSvg: json['img_url_svg'],
        imgUrlJpg: json['img_url_jpg'],
        imgUrlSvgAlt: json['img_url_svg_alt'],
        poseCount: int.parse(json['poseCount']),
      );
}

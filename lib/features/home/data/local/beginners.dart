import 'package:yoga_training_app/models/style.dart';

final _standStyle = Style(
  imageUrl: 'assets/images/pose2.png',
  name: 'Standing Style',
  time: 5,
);
final _sittingStyle = Style(
  imageUrl: 'assets/images/pose1.png',
  name: 'Sitting Style',
  time: 8,
);
final _legCrossStyle = Style(
  imageUrl: 'assets/images/pose3.png',
  name: 'Leg Cross Style',
  time: 6,
);

final beginners = [_standStyle, _sittingStyle, _legCrossStyle];

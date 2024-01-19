import 'dart:convert';
import 'package:http/http.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/data-sources/course.data-source.dart';
import 'package:yoga_training_app/config/environment_config.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  @override
  Future<List<Course>> getAllCourses(String accessToken) async {
    return await this.getCourses(accessToken, 'session');
  }

  Future<List<Course>> getCourses(String accessToken, String endpoint) async {
    List<Course> courseList = [];
    try {
      Response response = await get(
        Uri.parse(EnvironmentConfig.getBaseUrl() + endpoint),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Assuming 'data' is a list of courses
        for (var courseJson in data) {
          courseList.add(ConvertJSONCourse(courseJson));
        }
      } else {
        printInternal('failed');
      }
    } catch (e) {
      printInternal(e.toString());
    }
    return courseList;
  }

  Future<List<Course>> getBeginnerCourses(String accessToken) async {
    return await this.getCourses(accessToken, 'session/difficulty/1');
  }

  Course ConvertJSONCourse(courseJson) {
    Course course = new Course(
        imageUrl: courseJson['poses'][0]['img_url_jpg'],
        name: courseJson['title'],
        description: courseJson['description'],
        time: courseJson['duration'],
        students: courseJson['difficulty']['difficulty_level'],
        poses: convertJSONPoses(courseJson));
    return course;
  }

  List<Pose> convertJSONPoses(courseJson) {
    List<Pose> poses = courseJson['poses']
        .map<Pose>((pose) => new Pose(
            sanskrit_name: pose['sanskrit_name'],
            english_name: pose['english_name'],
            description: pose['description'],
            benefits: pose['benefits'],
            img_url_svg: pose['img_url_svg'],
            img_url_jpg: pose['img_url_jpg'],
            img_url_svg_alt: pose['img_url_svg_alt']))
        .toList();
    return poses;
  }
}

import 'dart:convert';

import 'package:http/http.dart';
import 'package:yoga_training_app/core/config/environment_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/data-sources/course.data-source.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  @override
  Future<List<Course>> getAllCourses(String accessToken) async {
    return await getCourses(accessToken, 'session');
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
          courseList.add(CourseRemoteDataSource.convertJSONCourse(courseJson));
        }
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        printInternal('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      printInternal(e.toString());
      rethrow;
    }
    return courseList;
  }

  @override
  Future<List<Course>> getBeginnerCourses(String accessToken) async {
    return await getCourses(accessToken, 'session/difficulty/1');
  }

  static Course convertJSONCourse(courseJson) {
    Course course = Course(
        id: courseJson['id'],
        imageUrl: courseJson['poses'][0]['img_url_jpg'],
        name: courseJson['title'],
        description: courseJson['description'],
        time: courseJson['duration'],
        students: courseJson['difficulty']['difficulty_level'],
        poses: CourseRemoteDataSource.convertJSONPoses(courseJson));
    return course;
  }

  static List<Pose> convertJSONPoses(courseJson) {
    List<Pose> poses = courseJson['poses']
        .map<Pose>((pose) => Pose(
            id: pose['id'],
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

import 'package:flutter/material.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/use-cases/search_courses.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

class SearchProvider extends ChangeNotifier {
  final SearchCoursesUseCase searchCoursesUseCase =
      InjectionContainer.provideSearchCoursesUseCase();
  List<Course> _results = [];
  bool _isLoading = false;

  List<Course> get results => _results;

  bool get isLoading => _isLoading;

  void search(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _results = await searchCoursesUseCase.call(query);
    } catch (e) {
      // Handle the error, possibly by notifying the UI to show a snackbar.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

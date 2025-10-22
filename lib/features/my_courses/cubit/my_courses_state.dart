part of 'my_courses_cubit.dart';

abstract class MyCoursesState {}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCoursesSuccess extends MyCoursesState {
  final List<ModuleItem> courses;

  MyCoursesSuccess(this.courses);
}

class MyCoursesError extends MyCoursesState {
  final String message;

  MyCoursesError(this.message);
}

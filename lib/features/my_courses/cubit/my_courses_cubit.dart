import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:student/features/my_courses/repo/my_courses_repo.dart';

part 'my_courses_state.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  final MyCoursesRepo _repo;

  MyCoursesCubit(this._repo) : super(MyCoursesInitial());

  Future<void> fetchStudentCourses() async {
    emit(MyCoursesLoading());
    try {
      final response = await _repo.getStudentCourses();
      emit(MyCoursesSuccess(response.result.courses));
    } catch (e) {
      emit(MyCoursesError(e.toString()));
    }
  }
}

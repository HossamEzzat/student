import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:student/features/home/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _repo;
  List<ModuleItem> _allModules = [];

  HomeCubit(this._repo) : super(HomeInitial());

  Future<void> fetchModules() async {
    emit(HomeLoading());

    try {
      final response = await _repo.getModulesWithCourses();

      if (response.success) {
        _allModules = response.result.modules;
        emit(HomeSuccess(_allModules));
      } else {
        emit(HomeFailure(response.message));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  void searchModules(String query) {
    if (query.isEmpty) {
      emit(HomeSuccess(_allModules));
      return;
    }

    final filteredModules = _allModules.where((module) {
      final nameLower = module.name.toLowerCase();
      final instructorLower = module.instructorName??''.toLowerCase();
      final descriptionLower = module.description.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower) ||
          instructorLower.contains(queryLower) ||
          descriptionLower.contains(queryLower);
    }).toList();

    emit(HomeSuccess(filteredModules));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/features/notifications/model/notifications_model.dart';
import 'package:student/features/notifications/repo/notifications_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo _repo;

  NotificationsCubit(this._repo) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());

    try {
      final response = await _repo.getNotifications();

      if (response.success) {
        emit(NotificationsSuccess(response.result.notifications));
      } else {
        emit(NotificationsFailure(response.message));
      }
    } catch (e) {
      emit(NotificationsFailure(e.toString()));
    }
  }
}

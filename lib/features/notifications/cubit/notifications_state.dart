part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationItem> notifications;

  NotificationsSuccess(this.notifications);
}

class NotificationsFailure extends NotificationsState {
  final String error;

  NotificationsFailure(this.error);
}

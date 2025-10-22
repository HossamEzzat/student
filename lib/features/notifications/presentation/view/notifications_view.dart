import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_appbar.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/notifications/cubit/notifications_cubit.dart';
import 'package:student/features/notifications/repo/notifications_repo.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(NotificationsRepo())..fetchNotifications(),
      child: Scaffold(
        appBar: const CustomAppbar(backgroundColor: Colors.transparent),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    const CustomText(
                      'Notifications',
                      color: ColorsUtils.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 20),
                    if (state is NotificationsLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else if (state is NotificationsFailure)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            CustomText(
                              'Error: ${state.error}',
                              color: Colors.red,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<NotificationsCubit>().fetchNotifications();
                              },
                              child: const CustomText('Retry'),
                            ),
                          ],
                        ),
                      )
                    else if (state is NotificationsSuccess)
                      if (state.notifications.isEmpty)
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_none,
                                size: 60,
                                color: ColorsUtils.grey,
                              ),
                              SizedBox(height: 16),
                              CustomText(
                                'No notifications yet',
                                color: ColorsUtils.grey,
                              ),
                            ],
                          ),
                        )
                      else
                        ...state.notifications.map((notification) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: notificationCard(
                              title: notification.title,
                              timeAgo: notification.timestamp,
                              subTitle: notification.content,
                            ),
                          );
                        }),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget notificationCard({
    required String title,
    required String timeAgo,
    required String subTitle,
  }) {
    const color = Color(0xff398DFF);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: const BorderSide(width: 1, color: ColorsUtils.grey2),
      ),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        child: const Icon(Icons.notifications_none_rounded, color: color),
      ),
      title: Row(
        children: [
          Expanded(
            child: CustomText(
              title,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: ColorsUtils.primary,
            ),
          ),
          CustomText(timeAgo, color: ColorsUtils.grey),
        ],
      ),
      subtitle: CustomText(subTitle, color: ColorsUtils.grey),
    );
  }
}

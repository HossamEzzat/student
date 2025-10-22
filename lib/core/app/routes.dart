import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/di/injection_container.dart';
import 'package:student/features/auth/presentation/view/login_view.dart';
import 'package:student/features/auth/presentation/view/register_view.dart';
import 'package:student/features/auth/presentation/view/complete_data/complete_data_view.dart';
import 'package:student/features/course/presentation/view/course_view.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:student/features/home/presentation/view/home_view.dart';
import 'package:student/features/my_courses/presentation/view/my_courses_view.dart';
import 'package:student/features/navigation_bottom/presentation/view/navigation_bottom_view.dart';
import 'package:student/features/notifications/presentation/view/notifications_view.dart';
import 'package:student/features/offline_videos/presentation/view/offline_videos_view.dart';
import 'package:student/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:student/features/reset_password/presentation/view/send_reset_code_view.dart';
import 'package:student/features/reset_password/presentation/view/verify_code_view.dart';
import 'package:student/features/reset_password/presentation/view/set_new_password_view.dart';
import 'package:student/features/settings/presentation/view/settings_view.dart';
import 'package:student/features/splash/presentation/view/splash_view.dart';

class Routes {
  // Splash & Onboarding
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';

  // Authentication
  static const String login = '/login';
  static const String register = '/register';
  static const String completeData = '/complete-data';

  // Reset Password
  static const String sendResetCode = '/send-reset-code';
  static const String verifyCode = '/verify-code';
  static const String setNewPassword = '/set-new-password';

  // Main Navigation
  static const String navigationBottom = '/navigation';
  static const String home = '/home';

  // Features
  static const String myCourses = '/my-courses';
  static const String offlineVideos = '/offline-videos';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String course = '/course';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case Routes.onBoarding:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());

    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.authCubit,
          child: const LoginView(),
        ),
      );

    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.authCubit,
          child: const RegisterView(),
        ),
      );

    case Routes.completeData:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.authCubit,
          child: const CompleteDataView(),
        ),
      );

    case Routes.sendResetCode:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.resetPasswordCubit,
          child: const SendResetCodeView(),
        ),
      );

    case Routes.verifyCode:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.resetPasswordCubit,
          child: const VerifyCodeView(),
        ),
      );

    case Routes.setNewPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: injectionContainer.resetPasswordCubit,
          child: const SetNewPasswordView(),
        ),
      );

    case Routes.navigationBottom:
      return MaterialPageRoute(builder: (_) => const NavigationBottomView());

    case Routes.home:
      return MaterialPageRoute(builder: (_) => const HomeView());

    case Routes.myCourses:
      return MaterialPageRoute(builder: (_) => const MyCoursesView());

    case Routes.offlineVideos:
      return MaterialPageRoute(builder: (_) => const OfflineVideosView());

    case Routes.settings:
      return MaterialPageRoute(builder: (_) => const SettingsView());

     case Routes.notifications:
      return MaterialPageRoute(builder: (_) => const NotificationsView());
    case Routes.course:
      final module = settings.arguments as ModuleItem;
      return MaterialPageRoute(builder: (_) =>  CourseView(module));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

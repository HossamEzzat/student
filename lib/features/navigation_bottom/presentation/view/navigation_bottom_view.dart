import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/features/home/presentation/view/home_view.dart';
import 'package:student/features/my_courses/presentation/view/my_courses_view.dart';
import 'package:student/features/offline_videos/presentation/view/offline_videos_view.dart';
import 'package:student/features/settings/presentation/view/settings_view.dart';

class NavigationBottomView extends StatefulWidget {
  const NavigationBottomView({super.key});

  @override
  State<NavigationBottomView> createState() => _NavigationBottomViewState();
}

class _NavigationBottomViewState extends State<NavigationBottomView> {
  final PersistentTabController _controller = PersistentTabController();

  final pages = [
    const HomeView(),
    const MyCoursesView(),
    const OfflineVideosView(),
    const SettingsView(),
  ];

  final List<Map<String, dynamic>> _navItemsData = [
    {'icon': AssetUtils.homeIcon, 'title': 'Home'},
    {'icon': AssetUtils.myCoursesIcon, 'title': 'My Courses'},
    {'icon': AssetUtils.offlineVideosIcon, 'title': 'Offline Videos'},
    {'icon': AssetUtils.userIcon, 'title': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: pages,
      onItemSelected: (i) {
        setState(() {});
      },
      items: List.generate(_navItemsData.length, (index) {
        final data = _navItemsData[index];
        final bool isSelected = _controller.index == index;

        final Color activeColor = ColorsUtils.main.withValues(alpha: 0.4);
        final Color secondActiveColor = const Color(0xff2ECC71);

        return PersistentBottomNavBarItem(
          icon: CustomImage(
            data['icon'],
            color: isSelected ? secondActiveColor : Colors.grey,
          ),
          title: data['title'],
          activeColorPrimary: activeColor,
          textStyle: TextStyle(
            color: isSelected ? secondActiveColor : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }),
      navBarStyle: NavBarStyle.style7,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/choose_user_type_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/complete_registration_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/select_college_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/select_level_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/select_university_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/start_page.dart';
import 'package:student/features/auth/presentation/view/complete_data/pages/success_message_page.dart';
import 'package:zapx/zapx.dart';

class CompleteDataView extends StatefulWidget {
  const CompleteDataView({super.key});

  @override
  State<CompleteDataView> createState() => _CompleteDataViewState();
}

class _CompleteDataViewState extends State<CompleteDataView> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool pagesBuilt = false;

  void nextPage([bool canNext = true]) {
    if (!canNext) return;

    final authCubit = context.read<AuthCubit>();

    if (currentPage == 1 && !pagesBuilt && authCubit.selectedUserType != null) {
      setState(() {
        pagesBuilt = true;
        currentPage++;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    final totalPages = _getTotalPages();
    if (currentPage < totalPages - 1) {
      setState(() => currentPage++);
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  int _getTotalPages() {
    final authCubit = context.read<AuthCubit>();
    if (!pagesBuilt || authCubit.selectedUserType == null) {
      return 2;
    }
    return authCubit.selectedUserType == 1 ? 6 : 4;
  }

  List<Widget> _buildPages() {
    final authCubit = context.read<AuthCubit>();
    final pages = <Widget>[
      StartPage(onNext: nextPage),
      ChooseUserTypePage(
        selectedType: authCubit.selectedUserType,
        onSelected: (type) {
          setState(() {
            authCubit.selectedUserType = type;
          });
        },
        onNext: () => nextPage(authCubit.selectedUserType != null),
      ),
    ];

    if (pagesBuilt && authCubit.selectedUserType != null) {
      if (authCubit.selectedUserType == 1) {
        pages.addAll([
          SelectUniversityPage(onNext: nextPage),
          SelectCollegePage(onNext: nextPage),
          SelectLevelPage(onNext: nextPage),
        ]);
      } else if (authCubit.selectedUserType == 2) {
        pages.add(CompleteRegistrationPage(onNext: nextPage));
      }
      pages.add(const SuccessMessagePage());
    }

    return pages;
  }

  String _getTitle() {
    final authCubit = context.read<AuthCubit>();
    if (authCubit.selectedUserType == 1) {
      final titles = [
        'Let\'s Get Started!',
        'Every Step Matters!',
        'One More!',
        'Almost There!',
        'And here we are!',
        'Success!',
      ];
      return currentPage < titles.length ? titles[currentPage] : '';
    } else if (authCubit.selectedUserType == 2) {
      final titles = [
        'Let\'s Get Started!',
        'Every Step Matters!',
        'Almost Done!',
        'Success!',
      ];
      return currentPage < titles.length ? titles[currentPage] : '';
    }
    return 'Let\'s Get Started!';
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    final totalPages = _getTotalPages();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (currentPage > 0 && currentPage < totalPages - 1) ...[
              CustomText(
                _getTitle(),
                color: ColorsUtils.primary,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: currentPage / (totalPages - 1),
                  backgroundColor: ColorsUtils.primary.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorsUtils.main,
                  ),
                ),
              ),
            ],
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),
            ),
          ],
        ).paddingAll(10),
      ),
    );
  }
}

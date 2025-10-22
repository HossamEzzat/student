import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/shared/widgets/default_appbar.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/my_courses/cubit/my_courses_cubit.dart';
import 'package:student/features/my_courses/presentation/widget/course_status_widget.dart';
import 'package:student/features/my_courses/repo/my_courses_repo.dart';
import 'package:zapx/zapx.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  int _refreshKey = 0;

  Future<void> _navigateToCourse(course) async {
    await Zap.toNamed(Routes.course, arguments: course);

    // Trigger rebuild of all course cards to refresh progress
    if (mounted) {
      setState(() {
        _refreshKey++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCoursesCubit(MyCoursesRepo())..fetchStudentCourses(),
      child: Scaffold(
        appBar: const DefaultAppbar(),
        body: BlocBuilder<MyCoursesCubit, MyCoursesState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const CustomText(
                  'My Courses',
                  color: ColorsUtils.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 16),
                if (state is MyCoursesLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(
                        color: ColorsUtils.main,
                      ),
                    ),
                  )
                else if (state is MyCoursesError)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          CustomText(
                            state.message,
                            color: Colors.red,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<MyCoursesCubit>().fetchStudentCourses();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsUtils.main,
                            ),
                            child: const CustomText(
                              'Retry',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state is MyCoursesSuccess)
                  state.courses.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.school_outlined,
                                  color: ColorsUtils.grey,
                                  size: 64,
                                ),
                                SizedBox(height: 16),
                                CustomText(
                                  'No courses yet',
                                  color: ColorsUtils.grey,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          key: ValueKey(_refreshKey),
                          spacing: 12,
                          children: state.courses
                              .map((course) => GestureDetector(
                                    onTap: () => _navigateToCourse(course),
                                    child: CourseStatusWidget(course: course),
                                  ))
                              .toList(),
                        ),
              ],
            );
          },
        ),
      ),
    );
  }
}

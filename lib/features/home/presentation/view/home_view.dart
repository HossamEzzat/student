import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/shared/widgets/default_appbar.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/home/cubit/home_cubit.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:student/features/home/presentation/widgets/picked_foryou_widget.dart';
import 'package:student/features/home/presentation/widgets/tutor_widget.dart';
import 'package:student/features/home/repo/home_repo.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepo())..fetchModules(),
      child: Scaffold(
        appBar: const DefaultAppbar(),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return CustomField(
                      hintText: 'Search for courses, tutors',
                      color: Colors.transparent,
                      borderColor: ColorsUtils.grey,
                      onChanged: (query) {
                        context.read<HomeCubit>().searchModules(query ?? '');
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                const CustomText(
                  'Picked for you',
                  fontWeight: FontWeight.w700,
                  color: ColorsUtils.primary,
                  fontSize: 16,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is HomeFailure) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 40,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                'Error: ${state.error}',
                                color: Colors.red,
                                textAlign: TextAlign.center,
                                fontSize: 12,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<HomeCubit>().fetchModules();
                                },
                                child: const CustomText('Retry', fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is HomeSuccess) {
                      return PickedForyouWidget(modules: state.modules);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Recommended Tutors',
                      fontWeight: FontWeight.w700,
                      color: ColorsUtils.primary,
                      fontSize: 16,
                    ),
                    CustomText(
                      'View All',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: ColorsUtils.main,
                    ),
                  ],
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeSuccess) {
                      // Get unique tutors from modules
                      final tutors = <String, ModuleItem>{};
                      for (var module in state.modules) {
                        if (!tutors.containsKey(module.instructorName)) {
                          tutors[module.instructorName??'N/A'] = module;
                        }
                      }

                      if (tutors.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      // Display up to 2 tutors
                      final tutorList = tutors.values.take(2).toList();
                      return Column(
                        spacing: 10,
                        children: tutorList
                            .map((module) => TutorWidget(
                                  tutorName: module.instructorName??'',
                                  tutorImage: module.coverImageUrl,
                                ))
                            .toList(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

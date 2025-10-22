import 'package:flutter/material.dart';
import 'package:student/core/network/api_service.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/features/course/presentation/widgets/about_tab_section.dart';
import 'package:student/features/course/presentation/widgets/content_tab_section.dart';
import 'package:student/features/course/presentation/widgets/documents_tab_section.dart';
import 'package:student/features/course/presentation/widgets/quizes_tab_section.dart';
import 'package:student/features/course/presentation/widgets/discussions_tab_section.dart';
import 'package:student/features/home/model/home_model.dart';

class CourseView extends StatelessWidget {
  const CourseView(this.module, {super.key});
  final ModuleItem module;

  @override
  Widget build(BuildContext context) {
    final hasContent = module.videos.isNotEmpty || module.documents.isNotEmpty;
   final imageUrl = module.coverImageUrl.startsWith('http')
              ? module.coverImageUrl
              : module.coverImageUrl.isEmpty?null:'${ApiService.baseUrl.replaceAll('/api', '')}${module.coverImageUrl}';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            leading: CustomContainer(
              isCircle: true,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double expandRatio =
                    (constraints.maxHeight - kToolbarHeight) /
                    (280.0 - kToolbarHeight);

                return FlexibleSpaceBar(
                  titlePadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  title: Opacity(
                    opacity: expandRatio < 0.3 ? 1.0 : 0.0,
                    child: CustomText(
                      module.name,
                      color: ColorsUtils.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImage(
            imageUrl??AssetUtils.logo,
                        fit: BoxFit.cover,
                      ),
                      CustomContainer(
                        color: Colors.black.withValues(alpha: 0.3),
                        padding: 0,
                      ),
                      CustomContainer(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.3),
                          ],
                        ),
                        padding: 0,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: CustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(24, 24, 24, 12),
                    child: Row(
                      children: [
                        CustomText(
                          '${module.price.toStringAsFixed(2)} EGP',
                          color: ColorsUtils.main,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      module.name,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorsUtils.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Row(
                      children: [
                        CustomText(
                          '${module.studentsCount} Students',
                          color: ColorsUtils.grey,
                          fontSize: 13,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: CustomText('•', color: ColorsUtils.grey),
                        ),
                        CustomText(
                          '${module.videos.length} Videos',
                          color: ColorsUtils.grey,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),
                  CustomContainer(
                    padding: 10,
                    border: Border.all(width: 1, color: ColorsUtils.grey2),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/100?img=12'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              module.doctorName,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            const CustomText(
                              'Instructor',
                              color: ColorsUtils.grey,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  hasContent
                      ? DefaultTabController(
                          length: 5,
                          child: Column(
                            children: [
                              const TabBar(
                                isScrollable: true,
                                indicatorColor: ColorsUtils.main,
                                labelColor: ColorsUtils.main,
                                unselectedLabelColor: ColorsUtils.grey,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                tabs: [
                                  Tab(text: 'About'),
                                  Tab(text: 'Content'),
                                  Tab(text: 'Documents'),
                                  Tab(text: 'Quizes'),
                                  Tab(text: 'Discussions'),
                                ],
                              ),
                              SizedBox(
                                height: 400,
                                child: TabBarView(
                                  children: [
                                    AboutTabSection(
                                         module.description),
                                    ContentTabSection(module.videos, module.id),
                                    DocumentsTabSection(
                                        module.documents),
                                    const QuizesTabSection(),
                                    const DiscussionsTabSection(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(24),
                          child: AboutTabSection(
                               module.description),
                        ),
                        if(!hasContent)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: CustomButton(
                      title: 'Get Course Now',
                      onPressed: () {},
                      backgroundColor: ColorsUtils.main,
                      removeWidth: true,
                      radius: 12,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

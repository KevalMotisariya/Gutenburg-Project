import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inkwell_library/core/constants/app_dimensions.dart';
import 'package:inkwell_library/core/constants/app_images.dart';
import 'package:inkwell_library/core/constants/app_routes.dart';
import 'package:inkwell_library/core/constants/app_text_styles.dart';
import 'package:inkwell_library/features/books/presentation/controllers/category_controller.dart';
import 'package:inkwell_library/features/books/presentation/widgets/genre_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryController controller = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: SvgPicture.asset(AppImages.pattern, fit: BoxFit.fill),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppDimensions.screenPadding,
                    right: AppDimensions.screenPadding,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Gutenburg\nProject",
                        style: AppTextStyles.heading1(context: context),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "A social catloging website that allows you\nto feely search it database of books,\nannotation and reviews.",
                        style: AppTextStyles.categoryDescription(
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                final element = controller.categoryList[index];

                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  tween: Tween<double>(begin: 30, end: 0),
                  curve: Curves.easeOut,
                  builder: (context, double value, child) {
                    final opacity = 1 - (value / 30);
                    final scale = 0.95 + (opacity * 0.05);

                    return Transform.translate(
                      offset: Offset(0, value),
                      child: Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.screenPadding,
                              vertical: 8,
                            ),
                            child: GenreCard(
                              title: element.name,
                              imageUrl: element.imageUrl,
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.books,
                                  arguments: element.name.toLowerCase(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inkwell_library/core/constants/app_colors.dart';
import 'package:inkwell_library/core/constants/app_dimensions.dart';
import 'package:inkwell_library/core/constants/app_images.dart';
import 'package:inkwell_library/core/constants/app_text_styles.dart';
import 'package:inkwell_library/core/widgets/common_search_field.dart';
import 'package:inkwell_library/features/books/presentation/controllers/books_controller.dart';
import 'package:inkwell_library/features/books/presentation/widgets/book_card.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late BooksController controller;
  late String category;

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 900) return 6;
    if (width >= 600) return 4;
    return 3;
  }

  @override
  void initState() {
    super.initState();
    category = Get.arguments;
    controller = BooksController(category: category);
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppImages.back,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.toUpperCase(),
          style: AppTextStyles.heading2(context: context),
        ),
      ),
      body: Column(
        children: [
          Container(
            // height: 150,
            width: double.infinity,
            color: AppColors.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding,
                vertical: AppDimensions.screenPadding,
              ),
              child: CommonSearchField(onChanged: controller.onSearchChanged),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.isLoading.value == false &&
                  controller.bookList.isEmpty) {
                return Center(
                  child: Text(
                    "No books found.",
                    style: AppTextStyles.searchText(context: context),
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!controller.isFetchingMore.value &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    controller.fetchBooks();
                  }
                  return false;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppDimensions.screenPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 12,
                    childAspectRatio: 100 / (162 + 50),
                  ),
                  itemCount: controller.bookList.length,
                  itemBuilder: (context, index) {
                    final book = controller.bookList[index];

                    return BookCard(
                      imageUrl: book['formats']['image/jpeg'] ?? "",
                      title: book['title'] ?? "",
                      author: book['authors'].isNotEmpty
                          ? book['authors'][0]['name']
                          : "Unknown",
                      onTap: () => controller.openBook(book),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

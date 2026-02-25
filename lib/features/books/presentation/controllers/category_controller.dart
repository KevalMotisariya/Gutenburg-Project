import 'package:get/get.dart';
import 'package:inkwell_library/core/constants/app_images.dart';
import 'package:inkwell_library/features/books/data/models/category_model.dart';

class CategoryController {
  RxList categoryList = <CategoryModel>[
    CategoryModel(name: "FICTION", imageUrl: AppImages.fiction),
    CategoryModel(name: "DRAMA", imageUrl: AppImages.drama),
    CategoryModel(name: "HUMOR", imageUrl: AppImages.humour),
    CategoryModel(name: "POLITICS", imageUrl: AppImages.politics),
    CategoryModel(name: "PHILOSOPHY", imageUrl: AppImages.philosophy),
    CategoryModel(name: "HISTORY", imageUrl: AppImages.history),
    CategoryModel(name: "ADVENTURE", imageUrl: AppImages.adventure),
  ].obs;
}

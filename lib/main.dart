import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkwell_library/core/constants/app_colors.dart';
import 'package:inkwell_library/core/constants/app_routes.dart';
import 'package:inkwell_library/features/books/presentation/pages/books_page.dart';
import 'package:inkwell_library/features/books/presentation/pages/category_page.dart';
import 'package:inkwell_library/features/books/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gutenburg Project",
      initialRoute: AppRoutes.splash,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashPage()),
        GetPage(name: AppRoutes.categories, page: () => CategoryPage()),
        GetPage(
          name: AppRoutes.books,
          page: () => BooksPage(),
        ), // Get.toNamed(Routes.books);
      ],
    );
  }
}

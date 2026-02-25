import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading1({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 46),
      color: AppColors.primaryColor,
    );
  }

  static TextStyle heading2({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 28),
      color: AppColors.primaryColor,
    );
  }

  static TextStyle genreTitle({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 18),
      color: AppColors.blackColor,
    );
  }

  static TextStyle bookTitle({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 12),
      color: AppColors.blackColor,
    );
  }

  static TextStyle searchText({required BuildContext context, Color? color}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 16),
      color: color ?? AppColors.greyColor,
    );
  }

  static TextStyle bookAuthor({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: _responsiveFont(context, 12),
      color: AppColors.greyColor,
    );
  }

  static TextStyle categoryDescription({required BuildContext context}) {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      fontSize: _responsiveFont(context, 16),
      color: AppColors.blackColor,
    );
  }

  static double _responsiveFont(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return size + 4;
    if (width >= 600) return size + 2;
    return size;
  }
}

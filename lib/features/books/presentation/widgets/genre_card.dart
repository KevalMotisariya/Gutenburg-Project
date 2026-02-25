import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inkwell_library/core/constants/app_colors.dart';
import 'package:inkwell_library/core/constants/app_dimensions.dart';
import 'package:inkwell_library/core/constants/app_images.dart';
import 'package:inkwell_library/core/constants/app_text_styles.dart';

class GenreCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const GenreCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.genreCardShadowColor,
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(imageUrl),
                ),
                const SizedBox(width: 12),
                Text(title, style: AppTextStyles.genreTitle(context: context)),
              ],
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(AppImages.next),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:inkwell_library/core/constants/app_dimensions.dart';
import 'package:inkwell_library/core/constants/app_text_styles.dart';

class BookCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 112 / 162,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.bookRadius),
              child: Image.network(imageUrl, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          Text(
            title.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bookTitle(context: context),
          ),
          const SizedBox(height: 4),
          Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bookAuthor(context: context),
          ),
        ],
      ),
    );
  }
}

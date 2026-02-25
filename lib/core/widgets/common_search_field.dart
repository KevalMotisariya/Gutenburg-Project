import 'package:flutter/material.dart';
import 'package:inkwell_library/core/constants/app_colors.dart';
import 'package:inkwell_library/core/constants/app_dimensions.dart';
import 'package:inkwell_library/core/constants/app_text_styles.dart';

class CommonSearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const CommonSearchField({super.key, required this.onChanged});

  @override
  State<CommonSearchField> createState() => _CommonSearchFieldState();
}

class _CommonSearchFieldState extends State<CommonSearchField> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: TextField(
        controller: controller,
        onChanged: widget.onChanged,
        cursorColor: AppColors.primaryColor,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.greyColor),
          hintStyle: AppTextStyles.searchText(context: context),

          isDense: true,
          suffixIcon: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return value.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () {
                        controller.clear();
                        widget.onChanged('');
                      },
                    );
            },
          ),
        ),
        style: AppTextStyles.searchText(
          context: context,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}

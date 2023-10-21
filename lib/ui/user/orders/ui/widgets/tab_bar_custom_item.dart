// ignore_for_file: non_constant_identifier_names
import '../../../../../utils/tools/file_importers.dart';

GestureDetector TabBarCustomItem(
        {required BuildContext context,
        required bool isActive,
        required String text,
        required VoidCallback onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.05,
        width: width(context) * 0.29,
        decoration: BoxDecoration(
            color: isActive ? Colors.deepPurple : AdaptiveTheme.of(context).theme.disabledColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Text(
            text.tr,
            style: AppTextStyles.bodyMedium(context,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : AdaptiveTheme.of(context).theme.backgroundColor == AppColors.c0F1620 ?  Colors.white : Colors.black),
          ),
        ),
      ),
    );

// ignore_for_file: non_constant_identifier_names

import 'package:time_slot/utils/tools/file_importers.dart';

Row OrderTextWidget(
        {required BuildContext context,
        bool isDate = false,
        Color? subtitleColor,
        required String type,
        IconData? icon,
        bool isLoading = false,
        required String value}) =>
    Row(
      children: [
        if (icon != null)
          Icon(icon,
              color: isDate
                  ? Colors.grey
                  : AdaptiveTheme.of(context).theme.hoverColor),
        if (icon != null) SizedBox(width: width(context) * 0.02),
        Text(
          type.tr,
          style: AppTextStyles.bodyMedium(context,
              fontWeight: FontWeight.bold, color: isDate ? Colors.black : null),
        ),
        SizedBox(
          width: 5.w,
        ),
        isLoading
            ? Container(
                margin: EdgeInsets.only(left: 8.w),
                height: width(context) * 0.03,
                width: width(context) * 0.03,
                child: CustomCircularProgressIndicator(
                    color: AdaptiveTheme.of(context).theme.hintColor),
              )
            : Text(
                value,
                style: AppTextStyles.bodyLargeSmall(context,
                    fontSize: 15.sp,
                    color: isDate ? Colors.black : subtitleColor),
              ),
      ],
    );

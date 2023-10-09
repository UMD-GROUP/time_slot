// ignore_for_file: non_constant_identifier_names

import 'package:time_slot/utils/tools/file_importers.dart';

Row OrderTextWidget(
        {required BuildContext context,
        bool isDate = false,
        required String type,
        IconData? icon,
        required String value}) =>
    Row(
      children: [
        if (icon != null)
          Icon(icon,
              color: isDate
                  ? Colors.black
                  : AdaptiveTheme.of(context).theme.hintColor),
        if (icon != null) SizedBox(width: width(context) * 0.02),
        Text(
          type.tr,
          style: AppTextStyles.bodyMedium(context,
              fontWeight: FontWeight.bold, color: isDate ? Colors.black : null),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          isDate ? formatStringToMoney(value) : value,
          style: AppTextStyles.bodyLargeSmall(context,
              fontSize: 15.sp, color: isDate ? Colors.black : null),
        ),
      ],
    );

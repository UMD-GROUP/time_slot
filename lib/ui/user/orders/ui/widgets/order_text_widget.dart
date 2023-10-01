// ignore_for_file: non_constant_identifier_names

import 'package:time_slot/utils/tools/file_importers.dart';

Row OrderTextWidget(
        {required BuildContext context,
        required String type,
        required String value}) =>
    Row(
      children: [
        Text(
          type.tr,
          style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          value,
          style: AppTextStyles.bodyLargeSmall(context, fontSize: 15.sp),
        ),
      ],
    );

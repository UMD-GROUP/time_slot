// ignore: must_be_immutable
import 'package:time_slot/ui/widgets/custom_progres_indicator.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class GlobalButton extends StatelessWidget {
  GlobalButton(
      {required this.onTap,
      required this.textColor,
      required this.title,
      required this.color,
      this.isLoading = false,
      Key? key})
      : super(key: key);
  String title;
  Color color;
  Color textColor;
  VoidCallback onTap;
  bool isLoading;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          alignment: Alignment.center,
          height: height(context) * 0.075,
          width: width(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h), color: color),
          child: isLoading
              ? const CustomCircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title.tr,
                  style: AppTextStyles.labelSBold(context, color: textColor),
                ),
        ),
      );
}

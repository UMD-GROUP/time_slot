import '../../../../../utils/tools/file_importers.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({required this.notificationModel, super.key});
  NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 15.h),
      );
}

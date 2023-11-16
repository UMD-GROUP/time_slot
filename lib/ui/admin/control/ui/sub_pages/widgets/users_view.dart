import 'package:time_slot/ui/admin/admin_home/ui/widget/user_item_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UsersView extends StatelessWidget {
  UsersView(this.users, {super.key});
  List<UserModel> users;

  @override
  Widget build(BuildContext context) => users.isEmpty
      ? Center(
          child: SizedBox(
              height: height(context) * 0.35,
              child: Lottie.asset(AppLotties.empty)),
        )
      : ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) =>
              UsersItemWidget(userModel: users[index], isPartner: true));
}

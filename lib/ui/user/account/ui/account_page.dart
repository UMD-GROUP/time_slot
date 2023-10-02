import 'package:time_slot/ui/user/account/ui/widgets/user_stores.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('User Account'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: const Column(
              children: [UserStores()],
            ),
          ),
        ),
      );
}

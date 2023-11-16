import 'package:time_slot/utils/tools/file_importers.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          title: Text('users'.tr, style: AppTextStyles.labelLarge(context)),
        ),
      );
}

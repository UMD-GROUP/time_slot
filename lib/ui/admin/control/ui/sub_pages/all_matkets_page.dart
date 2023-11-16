import 'package:time_slot/utils/tools/file_importers.dart';

class AllMarketsPage extends StatelessWidget {
  const AllMarketsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          title: Text('markets'.tr, style: AppTextStyles.labelLarge(context)),
        ),
      );
}

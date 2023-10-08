import 'package:time_slot/ui/user/membership/ui/widget/purchases_widget.dart';
import 'package:time_slot/ui/user/membership/ui/widget/user_card.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('membership'.tr),
        ),
        body: Container(
          padding: EdgeInsets.all(20.h),
          height: height(context),
          width: width(context),
          child: const Column(
            children: [UserCard(), PurchasesWidget()],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // postPurchases(context.read<UserBloc>().state.user!.uid,
        //     //     context.read<UserBloc>().state.user!.referallId);
        //     context.read<PurchaseBloc>().add(GetPurchasesEvent());
        //   },
        // ),
      );
}

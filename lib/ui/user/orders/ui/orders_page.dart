import 'package:feature_discovery/feature_discovery.dart';
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
import 'package:time_slot/ui/user/orders/ui/widgets/make_an_order_button.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    if (context.read<UserAccountBloc>().state.user == null) {
      context
          .read<UserAccountBloc>()
          .add(GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: OnTap(
              onTap: () {
                if (context.read<UserAccountBloc>().state.user.isAdmin) {
                  showAdminPasswordDialog(context, TextEditingController());
                }
              },
              child: Text('Seller PRO'.tr,
                  style: AppTextStyles.labelLarge(context,
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800))),
          leading: BlocBuilder<UserAccountBloc, UserAccountState>(
            builder: (context, userState) => Visibility(
              visible: !userState.user.isNull,
              child: DescribedFeatureOverlay(
                allowShowingDuplicate: true,
                backgroundDismissible: true,

                featureId:
                    'add_store', // Unique id that identifies this overlay.
                tapTarget: IconButton(
                    onPressed: () {
                      FeatureDiscovery.completeCurrentStep(context);

                      Navigator.pushNamed(context, RouteName.account);
                    },
                    icon: const Icon(Icons
                        .account_circle_outlined)), // The widget that will be displayed as the tap target.
                title: Text('account'.tr),
                description: Text('first_add_your_store'.tr),
                backgroundColor: Theme.of(context).primaryColor,
                // onBackgroundTap: () async {
                //   await Navigator.pushNamed(context, RouteName.account);
                //   return true;
                // },
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.account);
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<UserAccountBloc>().add(
                      GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
                  context.read<OrderBloc>().add(GetOrderEvent());
                  context.read<DataFromAdminBloc>().add(GetBannersEvent());
                  context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
                  getMyToast('updated'.tr);
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            Column(children: [
              SizedBox(height: height(context) * 0.02),
              BlocBuilder<DataFromAdminBloc, DataFromAdminState>(
                builder: (context, state) {
                  if (state.status == ResponseStatus.inSuccess) {
                    return BannerCard(
                        context.read<DataFromAdminBloc>().state.data!.banners);
                  }
                  return BannerCard(const []);
                },
              ),
              SizedBox(height: height(context) * 0.01),
              const TabBarWidget()
            ]),
            const MakeAnOrderButton()
          ],
        ),
      );
}

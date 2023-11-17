import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
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
          title: OnTap(
              onTap: () {
                if (context.read<UserAccountBloc>().state.user.isAdmin) {
                  showAdminPasswordDialog(context, TextEditingController());
                }
              },
              child: Text('Seller PRO'.tr)),
          leading: DescribedFeatureOverlay(
            featureId: 'add_store3', // Unique id that identifies this overlay.
            tapTarget: const Icon(Icons
                .account_circle_outlined), // The widget that will be displayed as the tap target.
            title: Text('account'.tr),
            description: Text('first_add_your_store'.tr),
            backgroundColor: Theme.of(context).primaryColor,
            onBackgroundTap: () async {
              await Navigator.pushNamed(context, RouteName.account);
              return true;
            },
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
                icon: const Icon(Icons.refresh))
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
              const Expanded(child: TabBarWidget())
            ]),
            Positioned(
              bottom: height(context) * 0.035,
              child: OnTap(
                onTap: () {
                  if (canNavigate(
                      context,
                      context.read<UserAccountBloc>().state.user,
                      context.read<DataFromAdminBloc>().state.data!)) {
                    context.read<CreateOrderBloc>().add(ReInitOrderEvent());
                    Navigator.pushNamed(context, RouteName.createOrder);
                  } else {
                    FeatureDiscovery.discoverFeatures(
                      context,
                      const <String>{
                        // Feature ids for every feature that you want to showcase in order.
                        'add_store3',
                      },
                    );
                  }
                },
                child: SizedBox(
                  width: width(context),
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 1,
                          right: 1,
                          child: RippleAnimation(
                            repeat: true,
                            color: Colors.deepPurple,
                            minRadius: 60,
                            ripplesCount: 6,
                            size: Size(
                                width(context) * 0.6, height(context) * 0.055),
                            child: SizedBox(
                              height: height(context) * 0.055,
                              width: width(context) * 0.6,
                            ),
                          ),
                        ),
                        Container(
                          height: height(context) * 0.055,
                          width: width(context) * 0.6,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.2),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(16.h)),
                          child: Text('make_an_order'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.labelLarge(context,
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}

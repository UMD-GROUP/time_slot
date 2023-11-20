import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class MakeAnOrderButton extends StatelessWidget {
  const MakeAnOrderButton({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserAccountBloc, UserAccountState>(
        builder: (context, state) => Visibility(
          visible: !state.user.isNull,
          child: Positioned(
            bottom: height(context) * 0.035,
            child: OnTap(
              onTap: () {
                if (canNavigate(
                    context,
                    context.read<UserAccountBloc>().state.user,
                    context.read<DataFromAdminBloc>().state.data!,
                    context.read<UserAccountBloc>().state.stores)) {
                  context.read<CreateOrderBloc>().add(ReInitOrderEvent());
                  Navigator.pushNamed(context, RouteName.createOrder);
                } else {
                  FeatureDiscovery.clearPreferences(context, ['add_store']);
                  FeatureDiscovery.discoverFeatures(
                    context,
                    const <String>{'add_store', 'add_store_1'},
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
          ),
        ),
      );
}

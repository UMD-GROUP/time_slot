// ignore_for_file: inference_failure_on_function_invocation

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserStores extends StatefulWidget {
  const UserStores({super.key});

  @override
  State<UserStores> createState() => _UserStoresState();
}

class _UserStoresState extends State<UserStores> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<UserAccountBloc, UserAccountState>(
        listener: (context, state) {
          if (state.addStoreStatus == ResponseStatus.inProgress) {
            // showLoadingDialog(context);
          }
          if (state.addStoreStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(
                text: state.message,
              ),
            ).show(context);
          } else if (state.addStoreStatus == ResponseStatus.inSuccess) {
            // Navigator.pop(context);
            // Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                color: AppColors.c7FCD51,
                text: 'added_successfully'.tr,
                icon: '',
              ),
            ).show(context);
            setState(() {});
          }
        },
        builder: (context, state) => Container(
          width: width(context),
          padding: EdgeInsets.symmetric(
              horizontal: 16.h, vertical: state.stores.isEmpty ? 10 : 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppImages.market, width: 28.w),
                  SizedBox(width: 8.w),
                  Text('markets'.tr,
                      style:
                          AppTextStyles.labelLarge(context, fontSize: 16.sp)),
                  const Spacer(),
                  if (state.stores.length != 5)
                    DescribedFeatureOverlay(
                      featureId: 'add_store_1',
                      title: Text('add_store'.tr),
                      description: Text('free_limit_bonus'.tr),
                      tapTarget: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple, // Background color
                          ),
                          onPressed: () {
                            FeatureDiscovery.completeCurrentStep(context);

                            showCupertinoDialog(
                                context: context,
                                builder: (context) => AddStoreDialog(
                                    user: context
                                        .read<UserAccountBloc>()
                                        .state
                                        .user!));
                          },
                          child: Text(
                            'add'.tr,
                            style:
                                TextStyle(fontSize: 11.sp, color: Colors.white),
                          )),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple, // Background color
                          ),
                          onPressed: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) => AddStoreDialog(
                                    user: context
                                        .read<UserAccountBloc>()
                                        .state
                                        .user!));
                          },
                          child: Text(
                            'add'.tr,
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          )),
                    ),
                ],
              ),
              Visibility(
                visible: state.stores.isEmpty,
                child: Text('no_markets_yet'.tr,
                    style: AppTextStyles.labelLarge(context,
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: height(context) * 0.01),
              ...List.generate(
                  state.stores.length,
                  (index) =>
                      StoreItem(index: index, store: state.stores[index])),
            ],
          ),
        ),
      );
}

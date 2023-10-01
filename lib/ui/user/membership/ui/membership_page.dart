import 'package:time_slot/utils/tools/file_importers.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Membership Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.h),
          height: height(context),
          width: width(context),
          child: Column(
            children: [
              Container(
                height: height(context) * 0.22,
                width: width(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    color: Colors.deepPurple),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${'balance'.tr}     125.000 so'm",
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "${'in_progress'.tr}     125.000 so'm",
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "${'referalls'.tr}     23 ta",
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "${'all_purchased'.tr}     945.000 so'm",
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                        ),
                        onPressed: () {},
                        child: Text('purchase'.tr))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ...List.generate(
                        7,
                        (index) => Container(
                              margin: EdgeInsets.symmetric(vertical: 12.h),
                              height: height(context) * 0.08,
                              width: width(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(color: Colors.deepPurple),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(Icons.monetization_on),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order number 0',
                                        style: AppTextStyles.labelLarge(context,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Text("925.000 so'm"),
                                      Text(
                                        'Jarayonda...',
                                        style: AppTextStyles.labelLarge(context,
                                            fontSize: 14, color: Colors.green),
                                      )
                                    ],
                                  ),
                                  const Visibility(
                                      visible: false, child: Icon(Icons.money)),
                                ],
                              ),
                            ))
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            postPurchases(context.read<UserBloc>().state.user!.uid,
                context.read<UserBloc>().state.user!.referallId);
          },
        ),
      );
}

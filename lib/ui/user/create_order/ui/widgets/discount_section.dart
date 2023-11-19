import 'package:time_slot/utils/tools/file_importers.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
          final int productsCount = state.order.products
                  .fold(0, (p, e) => int.parse((p + e.count).toString())) -
              state.order.freeLimit;
          num percent = 0;
          if (productsCount >= 100 && productsCount <= 199) {
            percent = 0.2;
          } else if (productsCount >= 200 && productsCount <= 499) {
            percent = 0.4;
          } else if (productsCount >= 500 && productsCount <= 999) {
            percent = 0.6;
          } else if (productsCount >= 1000 && productsCount <= 1999) {
            percent = 0.8;
          } else if (productsCount >= 2000) {
            percent = 1;
          }

          print(percent);
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.h),
                    width: width(context),
                    height: 26.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        border: Border.all(color: Colors.deepPurple)),
                    child: LinearProgressIndicator(
                      minHeight: 24.h,
                      borderRadius: BorderRadiusGeometry.lerp(
                        BorderRadius.circular(20.h),
                        BorderRadius.zero,
                        0.5, // Adjust this value to interpolate between the specified border radius and no radius.
                      )!,
                      backgroundColor: AdaptiveTheme.of(context)
                          .theme
                          .backgroundColor
                          .withOpacity(0.9),
                      color: Colors.deepPurple,
                      value: percent.toDouble(),
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('10%', style: AppTextStyles.labelLarge(context)),
                          Text('15%', style: AppTextStyles.labelLarge(context)),
                          Text('20%', style: AppTextStyles.labelLarge(context)),
                          Text('25%', style: AppTextStyles.labelLarge(context)),
                          Text('30%', style: AppTextStyles.labelLarge(context)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Container(
                          height: 26.h,
                          width: 2.h,
                          color: productsCount < 100 ? Colors.deepPurple : null,
                        ),
                        const Spacer(),
                        Container(
                          height: 26.h,
                          width: 2.h,
                          color: productsCount < 200 ? Colors.deepPurple : null,
                        ),
                        const Spacer(),
                        Container(
                          height: 26.h,
                          width: 2.h,
                          color: productsCount < 500 ? Colors.deepPurple : null,
                        ),
                        const Spacer(),
                        Container(
                          height: 26.h,
                          width: 2.h,
                          color:
                              productsCount < 1000 ? Colors.deepPurple : null,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height(context) * 0.01),
              SizedBox(
                height: 24.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: width(context) * 0.11,
                          child: Text('100 ',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.labelLarge(context))),
                      SizedBox(
                          width: width(context) * 0.11,
                          child: Text('200 ',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.labelLarge(context))),
                      SizedBox(
                          width: width(context) * 0.11,
                          child: Text('500 ',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.labelLarge(context))),
                      SizedBox(
                          width: width(context) * 0.11,
                          child: Text('1000',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.labelLarge(context))),
                      SizedBox(
                          width: width(context) * 0.09,
                          child: Text('2000',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.labelLarge(context))),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
}

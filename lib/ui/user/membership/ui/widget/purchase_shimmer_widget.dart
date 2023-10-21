import 'package:time_slot/utils/tools/file_importers.dart';

class PurchaseShimmerWidget extends StatelessWidget {
  const PurchaseShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
    child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index )=> CustomShimmer(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            height: height(context) * 0.11,
            width: width(context),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.3, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        )
    ),
  );
}

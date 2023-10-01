import 'package:time_slot/utils/tools/file_importers.dart';

class OrderShimmerWidget extends StatelessWidget {
  const OrderShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
      child: ListView.builder(
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index )=> Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.w),
            child: CustomShimmer(
              child: Container(
                height: height(context)*0.15,
                width: width(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          )
      ),
  );
}

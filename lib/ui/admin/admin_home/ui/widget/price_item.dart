// ignore_for_file: cascade_invocations

import 'package:time_slot/utils/tools/file_importers.dart';

class PriceItem extends StatelessWidget {
  PriceItem({required this.index, super.key});
  int index;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: () {
          controller.text = context
              .read<DataFromAdminBloc>()
              .state
              .data!
              .prices[index]
              .toString();
          showPriceInputDialog(context, () {
            if (controller.text.isNotEmpty) {
              Navigator.pop(context);
              final List prices =
                  context.read<DataFromAdminBloc>().state.data!.prices;
              prices[index] = int.parse(controller.text.trim());
              context.read<AdminBloc>().add(UpdatePricesEvent(prices));
            }
          }, controller);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text((index + 1).toString(),
                  style: AppTextStyles.labelLarge(context)),
              Container(
                alignment: Alignment.center,
                height: height(context) * 0.043,
                width: width(context) * 0.2,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Text(
                    formatStringToMoney(context
                        .read<DataFromAdminBloc>()
                        .state
                        .data!
                        .prices[index]
                        .toString()),
                    style: AppTextStyles.labelLarge(context)),
              ),
            ],
          ),
        ),
      );
}

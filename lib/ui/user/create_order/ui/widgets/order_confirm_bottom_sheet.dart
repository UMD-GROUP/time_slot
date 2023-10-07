// ignore_for_file: cascade_invocations

import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class InfoBottomSheet extends StatelessWidget {
  InfoBottomSheet({super.key, required this.order});
  OrderModel order;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: Text(
          '${'order_detail'.tr}:',
          style: AppTextStyles.labelLarge(context,
              fontSize: 18, color: Colors.black),
        ),
        message: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${'market_name'.tr}${order.marketName}',
              style: AppTextStyles.labelLarge(context,
                  fontSize: 18, color: Colors.black),
            ),
            Text(
              '${'dates_count'.tr}${order.dates.length}',
              style: AppTextStyles.labelLarge(context,
                  fontSize: 18, color: Colors.black),
            ),
            Text(
              '${'products_count'.tr}${order.products.length}',
              style: AppTextStyles.labelLarge(context,
                  fontSize: 18, color: Colors.black),
            ),
            Text(
              '${'service_price'.tr}${formatStringToMoney(order.sum.toString())}'
              ' UZS',
              style: AppTextStyles.labelLarge(context,
                  fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16),
          ],
        ),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                final OrderModel order =
                    context.read<CreateOrderBloc>().state.order;
                order.referallId =
                    context.read<UserBloc>().state.user!.referallId;
                order.ownerId = context.read<UserBloc>().state.user!.uid;

                context.read<CreateOrderBloc>().add(
                    AddOrderEvent(order, context.read<UserBloc>().state.user!));
              },
              child: Text('confirm'.tr))
        ],
      );
}

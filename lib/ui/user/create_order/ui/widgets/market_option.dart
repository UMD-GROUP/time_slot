// ignore_for_file: cascade_invocations

import 'package:time_slot/utils/tools/file_importers.dart';

class MarketOption extends StatelessWidget {
  const MarketOption({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) => SizedBox(
          width: width(context),
          child: Wrap(
            children: [
              for (final i in context.read<UserAccountBloc>().state.stores)
                RadioListTile(
                  title: Text(
                    i.name,
                    // style: AppTextStyles.labelLarge(context)
                  ),
                  value: i.name,
                  groupValue: state.order.marketName,
                  onChanged: (value) {
                    final OrderModel order = state.order;
                    order.marketName = value.toString();
                    context
                        .read<CreateOrderBloc>()
                        .add(UpdateFieldsOrderEvent(order));
                  },
                )
            ],
          ),
        ),
      );
}

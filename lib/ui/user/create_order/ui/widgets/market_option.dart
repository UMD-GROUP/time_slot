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
              for (final i in context.read<UserBloc>().state.user!.markets)
                RadioListTile(
                  title: Text(i, style: AppTextStyles.labelLarge(context)),
                  value: i,
                  groupValue: state.order.marketName,
                  onChanged: (value) {
                    final OrderModel order = state.order;
                    order.marketName = value;
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

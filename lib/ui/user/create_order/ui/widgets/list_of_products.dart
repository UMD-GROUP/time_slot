import 'package:time_slot/utils/tools/file_importers.dart';

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).theme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView.builder(
            itemCount: state.order.products.length,
            itemBuilder: (context, index) {
              final item = state.order.products[index];

              return ListTile(
                title: Text(
                  item.deliveryNote,
                  style: AppTextStyles.labelLarge(context, fontSize: 18),
                ),
                subtitle: Text(
                  item.count.toString(),
                  style: AppTextStyles.labelLarge(context, fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    final int productsCount = state.order.products
                        .fold(0, (p, e) => int.parse((p + e.count).toString()));
                    if (!state.order.promoCode.isNull) {
                      if (productsCount - state.order.products[index].count <
                          state.order.promoCode!.minAmount) {
                        showConfirmCancelDialog(context, () {
                          Navigator.pop(context);
                          final OrderModel order = state.order;
                          order.products.removeAt(index);
                          order.promoCode = null;
                          context.read<CreateOrderBloc>().add(
                              UpdateFieldsOrderEvent(
                                  order,
                                  context
                                      .read<DataFromAdminBloc>()
                                      .state
                                      .data!
                                      .orderMinAmount,
                                  freeLimit: context
                                      .read<UserAccountBloc>()
                                      .state
                                      .user
                                      .freeLimits));
                        },
                            title: 'you_can_not_remove_product'.trParams({
                              'count':
                                  state.order.promoCode!.minAmount.toString()
                            }));
                      } else {
                        final OrderModel order = state.order;
                        order.products.removeAt(index);
                        context.read<CreateOrderBloc>().add(
                            UpdateFieldsOrderEvent(
                                order,
                                context
                                    .read<DataFromAdminBloc>()
                                    .state
                                    .data!
                                    .orderMinAmount,
                                freeLimit: context
                                    .read<UserAccountBloc>()
                                    .state
                                    .user
                                    .freeLimits));
                      }
                    } else {
                      final OrderModel order = state.order;
                      order.products.removeAt(index);
                      context.read<CreateOrderBloc>().add(
                          UpdateFieldsOrderEvent(
                              order,
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .orderMinAmount,
                              freeLimit: context
                                  .read<UserAccountBloc>()
                                  .state
                                  .user
                                  .freeLimits));
                    }
                    getMyToast('deleted'.tr);
                  },
                ),
              );
            },
          ),
        ),
      );
}

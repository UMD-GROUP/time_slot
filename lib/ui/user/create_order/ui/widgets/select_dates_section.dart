// ignore_for_file: prefer_expression_function_bodies, cascade_invocations

import 'package:time_slot/ui/user/orders/ui/widgets/order_text_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class SelectDatesSection extends StatefulWidget {
  const SelectDatesSection({super.key});

  @override
  State<SelectDatesSection> createState() => _SelectDatesSectionState();
}

class _SelectDatesSectionState extends State<SelectDatesSection> {
  @override
  Widget build(BuildContext context) {
    final calendarController = CleanCalendarController(
      minDate: DateTime.now().add(const Duration(days: 2)),
      maxDate: DateTime.now().add(const Duration(days: 11)),
      onRangeSelected: (firstDate, secondDate) {},
      rangeMode: false,
      onDayTapped: (date) {
        context.read<PrivilegeBloc>().add(GetTheReverseEvent(date));
      },
      // readOnly: true,
      onPreviousMinDateTapped: (date) {},
      onAfterMaxDateTapped: (date) {},
      initialFocusDate: context.read<CreateOrderBloc>().state.order.date,
      // endDateSelected: DateTime(2022, 3, 20),
    );
    return Column(children: [
      BlocConsumer<PrivilegeBloc, PrivilegeState>(
        listener: (context, state) {
          if (state.reservesStatus == ResponseStatus.inSuccess) {
            final OrderModel order =
                context.read<CreateOrderBloc>().state.order;
            final int productCount = order.products
                .fold(0, (p, e) => int.parse((p + e.count).toString()));
            if (productCount <= state.reserve!.reserve) {
              order.reserve = state.reserve;
              order.date = state.reserve!.date;
              context.read<CreateOrderBloc>().add(UpdateFieldsOrderEvent(order,
                  context.read<DataFromAdminBloc>().state.data!.orderMinAmount,
                  freeLimit:
                      context.read<UserAccountBloc>().state.user.freeLimits));
            } else {
              AnimatedSnackBar(
                duration: const Duration(seconds: 5),
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppErrorSnackBar(
                    text: 'selected_date_has_no_enough_reserve'.trParams({
                  'count': state.reserve!.reserve.toString(),
                  'date': dateTimeToFormat(state.reserve!.date, needTime: false)
                })),
              ).show(context);
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              OrderTextWidget(
                  isLoading: state.reservesStatus == ResponseStatus.inProgress,
                  icon: Icons.real_estate_agent_outlined,
                  context: context,
                  type: '${'restriction'.tr}:',
                  value: state.reserve.isNull
                      ? '0 ${'piece'.tr}'
                      : '${state.reserve!.reserve} ${'piece'.tr}'),
              OrderTextWidget(
                  isLoading: state.reservesStatus == ResponseStatus.inProgress,
                  icon: Icons.attach_money,
                  context: context,
                  type: 'price_per_one',
                  value: state.reserve.isNull
                      ? '0 UZS'
                      : '${state.reserve!.price} UZS'),
            ],
          );
        },
      ),
      SizedBox(
        height: height(context) * 0.45,
        width: width(context),
        child: Theme(
          data: AdaptiveTheme.of(context).theme,
          child: ScrollableCleanCalendar(
            locale: getIt<StorageService>().getString('language').isEmpty
                ? 'uz'
                : getIt<StorageService>().getString('language'),
            calendarController: calendarController,
            weekdayTextStyle: AppTextStyles.labelLarge(context, fontSize: 12),
            layout: Layout.BEAUTY,
            calendarCrossAxisSpacing: 0,
          ),
        ),
      ),
      const SizedBox(height: 8),
    ]);
  }
}

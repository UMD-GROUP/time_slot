// ignore_for_file: prefer_expression_function_bodies, cascade_invocations

import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:time_slot/ui/user/orders/ui/widgets/order_text_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class SelectDatesSection extends StatefulWidget {
  const SelectDatesSection({super.key});

  @override
  State<SelectDatesSection> createState() => _SelectDatesSectionState();
}

class _SelectDatesSectionState extends State<SelectDatesSection> {
  final calendarController = CleanCalendarController(
    minDate: DateTime.now().add(const Duration(days: 1)),
    maxDate: DateTime.now().add(const Duration(days: 10)),
    onRangeSelected: (firstDate, secondDate) {},
    rangeMode: false,
    onDayTapped: (date) {
      // final OrderModel order = context.read<CreateOrderBloc>().state.order;
      // context.read<CreateOrderBloc>().add(UpdateFieldsOrderEvent(order))
    },
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    // initialFocusDate: DateTime(2023, 5),
    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime(2022, 3, 20),
  );

  @override
  Widget build(BuildContext context) => Column(children: [
        BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) {
            return OrderTextWidget(
                icon: Icons.attach_money,
                context: context,
                type: 'price_per_one',
                value: [].isEmpty ? '0 UZS' : '0 UZS');
          },
        ),
        SizedBox(
          height: height(context) * 0.45,
          width: width(context),
          child: Theme(
            data: AdaptiveTheme.of(context).theme,
            child: ScrollableCleanCalendar(
              calendarController: calendarController,
              layout: Layout.BEAUTY,
              calendarCrossAxisSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ]);
}

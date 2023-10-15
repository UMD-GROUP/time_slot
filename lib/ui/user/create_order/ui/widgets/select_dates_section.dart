// ignore_for_file: prefer_expression_function_bodies, cascade_invocations

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
import 'package:time_slot/ui/user/orders/ui/widgets/order_text_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class SelectDatesSection extends StatefulWidget {
  const SelectDatesSection({super.key});

  @override
  State<SelectDatesSection> createState() => _SelectDatesSectionState();
}

class _SelectDatesSectionState extends State<SelectDatesSection> {
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else if (selectedDay
              .isAfter(DateTime.now().add(const Duration(days: 1))) &&
          _selectedDays.length != 15) {
        _selectedDays.add(selectedDay);
        final OrderModel order = context.read<CreateOrderBloc>().state.order;
        order.dates = _selectedDays.toList();
        context.read<CreateOrderBloc>().add(UpdateFieldsOrderEvent(order));
      }
    });
    String error = '';
    if (!selectedDay.isAfter(DateTime.now())) {
      error = 'date_must_be_after'.tr;
    } else if (_selectedDays.length == 15) {
      error = 'date_limit_reached'.tr;
    }
    if (error.isNotEmpty) {
      AnimatedSnackBar(
        duration: const Duration(seconds: 4),
        snackBarStrategy: RemoveSnackBarStrategy(),
        builder: (context) => AppErrorSnackBar(text: error),
      ).show(context);
    }

    _selectedEvents.value = _getEventsForDays(_selectedDays);
    final OrderModel order = context.read<CreateOrderBloc>().state.order;
    order.dates = _selectedDays.toList();
    context.read<CreateOrderBloc>().add(UpdateFieldsOrderEvent(order));
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocBuilder<CreateOrderBloc, CreateOrderState>(
            builder: (context, state) {
              return OrderTextWidget(
                  isDate: true,
                  icon: Icons.attach_money,
                  context: context,
                  type: 'price_per_one',
                  value: _selectedDays.isEmpty
                      ? '0'
                      : context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .prices[_selectedDays.length - 1]
                          .toString());
            },
          ),
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: _selectedDays.contains,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          )
        ],
      );
}

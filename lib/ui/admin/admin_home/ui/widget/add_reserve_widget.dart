import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:time_slot/service/storage_service/storage_service.dart';
import 'package:time_slot/ui/admin/admin_home/bloc/reserve_bloc/reserve_bloc.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/reserve_information.dart';
import 'package:time_slot/ui/widgets/custom_progres_indicator.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AddReserveWidget extends StatelessWidget {
  const AddReserveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarController = CleanCalendarController(
      minDate: DateTime.now().add(const Duration(days: 2)),
      maxDate: DateTime.now().add(const Duration(days: 30)),
      initialFocusDate: DateTime.now().add(const Duration(days: 2)),
      weekdayStart: 7,
      rangeMode: false,
      onDayTapped: (date) {
        context.read<ReserveBloc>().add(ChangeCurrentReserveEvent(date));
      },
      // readOnly: true,
      onPreviousMinDateTapped: (date) {},
      onAfterMaxDateTapped: (date) {},
      // initialFocusDate: DateTime(2023, 5),
      // initialDateSelected: DateTime(2022, 3, 15),
      // endDateSelected: DateTime(2022, 3, 20),
    );
    return Expanded(
      child: BlocConsumer<ReserveBloc, ReserveState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.gettingStatus == ResponseStatus.inSuccess) {
            return Scaffold(
              backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.deepPurpleAccent,
                child: const Icon(Icons.add, color: Colors.white),
              ),
              body: Container(
                margin: EdgeInsets.all(20.h),
                width: width(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    border: Border.all(color: Colors.deepPurple)),
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text('reserve_information'.tr,
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyles.labelLarge(context, fontSize: 20.sp)),
                    const ReserveInformation(),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      height: height(context) * 0.4,
                      child: Theme(
                        data: AdaptiveTheme.of(context).theme,
                        child: ScrollableCleanCalendar(
                          locale: getIt<StorageService>().getString('language'),
                          calendarController: calendarController,
                          layout: Layout.BEAUTY,
                          calendarCrossAxisSpacing: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const CustomCircularProgressIndicator(color: Colors.white);
        },
      ),
    );
  }
}

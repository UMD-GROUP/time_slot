// ignore_for_file: cascade_invocations
import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AddReserveWidget extends StatelessWidget {
  const AddReserveWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocConsumer<ReserveBloc, ReserveState>(
          listener: (context, state) {
            if (state.updatingStatus == ResponseStatus.inProgress) {
              showLoadingDialog(context);
            } else if (state.updatingStatus == ResponseStatus.inSuccess) {
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppSnackBar(
                  color: AppColors.c7FCD51,
                  text: 'added_successfully'.tr,
                  icon: '',
                ),
              ).show(context);
              Navigator.pop(context);
            } else if (state.updatingStatus == ResponseStatus.inFail) {
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                duration: const Duration(seconds: 6),
                builder: (context) => AppErrorSnackBar(text: state.message),
              ).show(context);
            }
          },
          builder: (context, state) {
            if (state.gettingStatus == ResponseStatus.inSuccess) {
              final calendarController = CleanCalendarController(
                minDate: DateTime.now().add(const Duration(days: 2)),
                maxDate: DateTime.now().add(const Duration(days: 30)),
                weekdayStart: 7,
                rangeMode: false,
                onDayTapped: (date) {
                  context.read<ReserveBloc>().add(ChangeCurrentReserveEvent(
                      date, context.read<ReserveBloc>().state.reserves.cast()));
                },
                // readOnly: true,
                onPreviousMinDateTapped: (date) {},
                onAfterMaxDateTapped: (date) {},
                initialFocusDate: state.currentReserve.isNull
                    ? DateTime.now().add(const Duration(days: 2))
                    : state.currentReserve!.date,
                initialDateSelected: state.currentReserve.isNull
                    ? DateTime.now().add(const Duration(days: 2))
                    : state.currentReserve!.date,
                // endDateSelected: DateTime(2022, 3, 20),
              );
              return Scaffold(
                backgroundColor:
                    AdaptiveTheme.of(context).theme.backgroundColor,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (!state.currentReserve.isNull) {
                      final TextEditingController reserveCtrl =
                          TextEditingController();
                      final TextEditingController priceCtrl =
                          TextEditingController();
                      showReserveDialog(context, state.currentReserve!,
                          onConfirmTap: () {
                        final ReserveModel reserveModel = state.currentReserve!;
                        reserveModel.price = int.parse(priceCtrl.text.trim());
                        reserveModel.reserve +=
                            int.parse(reserveCtrl.text.trim());
                        if (reserveModel.isNew) {
                          context
                              .read<ReserveBloc>()
                              .add(CreateTheReserveEvent(reserveModel));
                        } else {
                          context
                              .read<ReserveBloc>()
                              .add(UpdateTheReserveEvent(reserveModel));
                        }
                      }, reserveCtrl, priceCtrl);
                    }
                  },
                  backgroundColor: Colors.deepPurpleAccent,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                body: Container(
                  margin: EdgeInsets.all(20.h),
                  width: width(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.h),
                      border: Border.all(color: Colors.deepPurple)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Text('reserve_information'.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelLarge(context,
                              fontSize: 20.sp)),
                      const ReserveInformation(),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        height: height(context) * 0.4,
                        child: Theme(
                          data: AdaptiveTheme.of(context).theme,
                          child: ScrollableCleanCalendar(
                            locale: getIt<StorageService>()
                                    .getString('language')
                                    .isEmpty
                                ? 'uz'
                                : getIt<StorageService>().getString('language'),
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
            return const CupertinoActivityIndicator();
          },
        ),
      );
}

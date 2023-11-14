import 'package:time_slot/ui/admin/admin_home/bloc/reserve_bloc/reserve_bloc.dart';
import 'package:time_slot/ui/admin/admin_home/data/models/reserve_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class ReserveInformation extends StatelessWidget {
  const ReserveInformation({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ReserveBloc, ReserveState>(
        builder: (context, state) {
          bool checkIsValid(DateTime day) =>
              !(day.isBefore(DateTime.now().add(const Duration(days: 1))) ||
                  day.isAfter(DateTime.now().add(const Duration(days: 11))));

          final List<ReserveModel> reserves = state.reserves.cast();
          final int allReserves = reserves.fold(
              0, (previousValue, element) => previousValue + element.reserve);

          final int activeReserves = reserves.fold(
              0,
              (previousValue, element) =>
                  previousValue +
                  (checkIsValid(element.date) ? element.reserve : 0));

          return Column(
            children: [
              SizedBox(height: height(context) * 0.01),
              RowText(
                  fontSize: 13.sp,
                  iconData: Icons.date_range,
                  text1: 'all_reserves',
                  text2: '$allReserves ${'piece'.tr}'),
              RowText(
                  fontSize: 13.sp,
                  iconData: Icons.data_exploration_outlined,
                  text1: 'active_reserves'.tr,
                  text2: '$activeReserves ${'piece'.tr}'),
              if (!state.currentReserve.isNull)
                RowText(
                    isVisible: !state.currentReserve.isNull,
                    fontSize: 13.sp,
                    iconData: Icons.calendar_month_outlined,
                    text1: 'date'.tr,
                    text2: dateTimeToFormat(state.currentReserve!.date)
                        .split(' ')
                        .first),
              if (!state.currentReserve.isNull)
                RowText(
                    isVisible: !state.currentReserve.isNull,
                    fontSize: 13.sp,
                    iconData: Icons.date_range_sharp,
                    text1: 'reserve'.tr,
                    text2: '${state.currentReserve!.reserve} ${'piece'.tr}'),
              if (!state.currentReserve.isNull)
                RowText(
                    isVisible: !state.currentReserve.isNull,
                    fontSize: 13.sp,
                    iconData: Icons.monetization_on,
                    text1: 'price'.tr,
                    text2: '${state.currentReserve!.price} UZS'),
            ],
          );
        },
      );
}

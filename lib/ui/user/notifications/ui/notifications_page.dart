import 'package:time_slot/ui/widgets/custom_progres_indicator.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          context.read<NotificationBloc>().add(GetAllNotificationsEvent());
          return true;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    if (state.status == ResponseStatus.inSuccess) {
                      return state.notifications.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.notifications.length,
                              itemBuilder: (context, index) {
                                final int currentIndex =
                                    state.notifications.length - index - 1;
                                getIt<NotificationBloc>().add(
                                    UpdateNotificationEvent(
                                        state.notifications[index],
                                        currentIndex));

                                return const SizedBox();
                              });
                    }
                    return CustomCircularProgressIndicator(
                        color: AdaptiveTheme.of(context).theme.hintColor);
                  },
                )
              ],
            ),
          ),
        ),
      );
}

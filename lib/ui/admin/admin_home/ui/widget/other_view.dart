// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/admin_home/ui/widget/other_item.dart';
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OtherView extends StatefulWidget {
  const OtherView({super.key});

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.updateOthersStatus == ResponseStatus.inSuccess) {
            context.read<DataFromAdminBloc>().add(GetBannersEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'added_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
            setState(() {});
          } else if (state.updateOthersStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.updateOthersStatus == ResponseStatus.inProgress) {
            Navigator.pop(context);
            showLoadingDialog(context);
          }
        },
        child: BlocBuilder<DataFromAdminBloc, DataFromAdminState>(
          builder: (context, state) => SizedBox(
            width: width(context),
            height: height(context) * 0.1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                OtherItem(
                    title: 'delivery_note'.tr,
                    onTap: () {
                      controller.text = context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .deliveryNote;
                      showNumberInputDialog(
                        inputFormatter: DeliveryNoteInputFormatter(),
                        context,
                        controller: controller,
                        hintText: 'enter_delivery_note'.tr,
                        title: 'delivery_note'.tr,
                        onConfirmTapped: () {
                          context.read<AdminBloc>().add(UpdateOtherEvent(
                              controller.text,
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .partnerPercent
                                  .toInt()));
                        },
                      );
                    },
                    subtitle: state.data!.deliveryNote),
                OtherItem(
                    title: 'member_percent',
                    onTap: () {
                      controller.text = context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .partnerPercent
                          .toString();
                      showNumberInputDialog(
                        inputFormatter: MemberPercentInputFormatter(),
                        context,
                        controller: controller,
                        hintText: 'enter_member_percent'.tr,
                        title: 'member_percent'.tr,
                        onConfirmTapped: () {
                          context.read<AdminBloc>().add(UpdateOtherEvent(
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .deliveryNote,
                              int.parse(controller.text)));
                        },
                      );
                    },
                    subtitle: '${state.data!.partnerPercent} %'),
                OtherItem(
                    title: 'instruction'.tr,
                    onTap: () {
                      controller.text = context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .instruction;
                      showTextInputDialog(
                        context,
                        controller: controller,
                        hintText: ' '.tr,
                        title: 'instruction'.tr,
                        onConfirmTapped: () {
                          final DataFromAdminModel data =
                              context.read<DataFromAdminBloc>().state.data!;
                          data.instruction = controller.text.trim();

                          context.read<AdminBloc>().add(UpdateOtherEvent(
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .deliveryNote,
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .partnerPercent
                                  .toInt(),
                              data: data));
                        },
                      );
                    },
                    subtitle: state.data!.instruction.isNotEmpty ? '+' : '-'),
                OtherItem(
                    title: 'terms_of_using'.tr,
                    onTap: () {
                      controller.text = context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .termsOfUsing
                          .toString();
                      showNumberInputDialog(
                        inputFormatter: MemberPercentInputFormatter(),
                        context,
                        controller: controller,
                        hintText: ' '.tr,
                        title: 'terms_of_using'.tr,
                        onConfirmTapped: () {
                          final DataFromAdminModel data =
                              context.read<DataFromAdminBloc>().state.data!;
                          data.termsOfUsing = controller.text.trim();

                          context.read<AdminBloc>().add(UpdateOtherEvent(
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .deliveryNote,
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .partnerPercent
                                  .toInt(),
                              data: data));
                        },
                      );
                    },
                    subtitle: state.data!.termsOfUsing.isNotEmpty ? '+' : '-'),
                OtherItem(
                    title: 'password'.tr,
                    onTap: () {
                      controller.text = context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .adminPassword
                          .toString();
                      showTextInputDialog(
                        context,
                        controller: controller,
                        hintText: ' '.tr,
                        title: 'password'.tr,
                        onConfirmTapped: () {
                          final DataFromAdminModel data =
                              context.read<DataFromAdminBloc>().state.data!;
                          data.adminPassword = controller.text.trim();

                          context.read<AdminBloc>().add(UpdateOtherEvent(
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .deliveryNote,
                              context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .partnerPercent
                                  .toInt(),
                              data: data));
                        },
                      );
                    },
                    subtitle: state.data!.adminPassword),
              ],
            ),
          ),
        ),
      );
}

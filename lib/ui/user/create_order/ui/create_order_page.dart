import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:time_slot/service/image_picker/image_picker_service.dart';
import 'package:time_slot/ui/user/create_order/bloc/step_controller/step_controller_bloc.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/add_product_section.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/market_option.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  List<DateTime> dates = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(context.read<UserBloc>().state.user!.email),
        ),
        body: SafeArea(
            child: Container(
          height: height(context),
          width: width(context),
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              BlocProvider(
                create: (context) => StepControllerBloc(),
                child: BlocBuilder<StepControllerBloc, StepControllerState>(
                  builder: (context, state) => Stepper(
                      onStepCancel: () {
                        context
                            .read<StepControllerBloc>()
                            .add(ToPreviousStepEvent());
                      },
                      currentStep: state.currentStep,
                      onStepContinue: () {
                        context
                            .read<StepControllerBloc>()
                            .add(ToNextStepEvent());
                      },
                      onStepTapped: (value) {
                        context
                            .read<StepControllerBloc>()
                            .add(ToStepEvent(value));
                      },
                      connectorColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                      steps: [
                        Step(
                          title: Text('choose_market'.tr),
                          content: const MarketOption(),
                        ),
                        Step(
                          title: Text('choose_dates'.tr),
                          content: CalendarDatePicker2(
                            config: CalendarDatePicker2Config(
                              calendarType: CalendarDatePicker2Type.multi,
                            ),
                            value: dates,
                            onValueChanged: (dates) {},
                          ),
                        ),
                        Step(
                            title: Text('products'.tr),
                            content: const AddProductSection()),
                        Step(
                            title: const Text('photo'),
                            content: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height(context) * 0.13,
                                    width: height(context) * 0.13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Colors.deepPurple)),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        final some = await showPicker(context);
                                        print(some);
                                        print('jfhsdjfhjsdhj');
                                      },
                                      child: Text('photo'.tr))
                                ],
                              ),
                            ))
                      ]),
                ),
              )
            ],
          ),
        )),
      );
}

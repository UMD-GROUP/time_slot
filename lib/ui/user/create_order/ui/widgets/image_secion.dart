// ignore_for_file: cascade_invocations, use_build_context_synchronously

import 'dart:io';

import 'package:time_slot/ui/user/create_order/ui/widgets/use_promo_code.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) => Column(
            children: [
              Visibility(
                  visible: state.order.promoCode.isNull,
                  child: const UsePromoCode()),
              SizedBox(height: height(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height(context) * 0.13,
                    width: height(context) * 0.13,
                    decoration: BoxDecoration(
                        image: state.order.userPhoto.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(File(state.order.userPhoto)))
                            : null,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.deepPurple)),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurpleAccent),
                      ),
                      onPressed: () async {
                        final photo = await showPicker(context);
                        final OrderModel order = state.order;
                        order.userPhoto = photo!.path;
                        context
                            .read<CreateOrderBloc>()
                            .add(UpdateFieldsOrderEvent(order));
                      },
                      child: Text('take_photo'.tr))
                ],
              )
            ],
          ),
        ),
      );
}

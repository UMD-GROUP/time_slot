// ignore_for_file: type_annotate_public_apis
import 'package:time_slot/utils/tools/file_importers.dart';

class AddProductSection extends StatefulWidget {
  const AddProductSection({super.key});

  @override
  State<AddProductSection> createState() => _AddProductSectionState();
}

class _AddProductSectionState extends State<AddProductSection> {
  TextEditingController deliveryNote = TextEditingController();
  TextEditingController count = TextEditingController();
  bool canAdd = false;

  void changeStatus() {
    canAdd = deliveryNote.text.length == 7 && count.text.isNotEmpty;
    setState(() {});
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const ListOfProducts(),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) => SizedBox(
          width: width(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('count_of_products'.tr,
                        style: AppTextStyles.labelLarge(context,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    Text(
                        '${state.order.products.length}  |  ${state.order.products.fold(0, (previousValue, element) => previousValue + int.parse(element.count.toString()))}'
                            .tr),
                  ],
                ),
                SizedBox(height: height(context) * 0.03),
                Visibility(
                  visible: state.order.products.isNotEmpty,
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple, // Background color
                          ),
                          onPressed: () {
                            showBottomSheet(context);
                          },
                          child: Text('show_products'.tr)),
                    ],
                  ),
                ),
                SizedBox(height: height(context) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        width: width(context) * 0.45,
                        height: height(context) * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('123456 -',
                                style: AppTextStyles.labelLarge(context,
                                    color: Colors.black, fontSize: 16)),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  changeStatus();
                                },
                                controller: deliveryNote,
                                inputFormatters: [SevenDigitInputFormatter()],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'delivery_note'.tr,
                                    border: InputBorder.none,
                                    iconColor: Colors.deepPurple),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                        width: width(context) * 0.17,
                        child: TextField(
                          controller: count,
                          onChanged: (value) {
                            changeStatus();
                          },
                          inputFormatters: [
                            ThreeDigitInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: Text('count'.tr),
                              iconColor: Colors.deepPurple,
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                        )),
                  ],
                ),
                SizedBox(height: height(context) * 0.01),
                Visibility(
                  visible: canAdd,
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple, // Background color
                          ),
                          onPressed: () {
                            final OrderModel order =
                                context.read<CreateOrderBloc>().state.order;
                            order.products.add(ProductModel(
                                count: int.parse(count.text),
                                deliveryNote: deliveryNote.text));
                            count.clear();
                            deliveryNote.clear();
                            changeStatus();

                            context
                                .read<CreateOrderBloc>()
                                .add(UpdateFieldsOrderEvent(order));
                          },
                          child: Text('add'.tr)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

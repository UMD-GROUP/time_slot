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
    canAdd = deliveryNote.text.length == 7 &&
        int.parse(count.text.trim().toString() ?? '1') >= 10;
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
                Visibility(
                  visible: state.order.products.length != 10,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(6)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              alignment: Alignment.center,
                              width: width(context) * 0.45,
                              height: height(context) * 0.06,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${context.read<DataFromAdminBloc>().state.data!.deliveryNote} -',
                                      style: AppTextStyles.labelLarge(context,
                                          color: Colors.black, fontSize: 16)),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        changeStatus();
                                      },
                                      controller: deliveryNote,
                                      inputFormatters: [
                                        SevenDigitInputFormatter()
                                      ],
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
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple))),
                              )),
                        ],
                      ),
                      SizedBox(height: height(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: state.order.products.isNotEmpty,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.deepPurple, // Background color
                                ),
                                onPressed: () {
                                  showBottomSheet(context);
                                },
                                child: Text('edit'.tr)),
                          ),
                          Visibility(
                            visible: canAdd,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.deepPurple, // Background color
                                ),
                                onPressed: () {
                                  final OrderModel order = context
                                      .read<CreateOrderBloc>()
                                      .state
                                      .order;
                                  order.products.add(ProductModel(
                                      count: int.parse(count.text),
                                      deliveryNote:
                                          '${context.read<DataFromAdminBloc>().state.data!.deliveryNote} ${deliveryNote.text}'));
                                  count.clear();
                                  deliveryNote.clear();
                                  changeStatus();

                                  context
                                      .read<CreateOrderBloc>()
                                      .add(UpdateFieldsOrderEvent(order));
                                },
                                child: Text('add'.tr)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

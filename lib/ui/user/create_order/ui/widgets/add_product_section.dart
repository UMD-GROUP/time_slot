import 'package:time_slot/utils/tools/file_importers.dart';

class AddProductSection extends StatelessWidget {
  const AddProductSection({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
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
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  Text('8 ta'.tr),
                ],
              ),
              SizedBox(height: height(context) * 0.03),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, // Background color
                      ),
                      onPressed: () {},
                      child: Text('show_products'.tr)),
                ],
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
                                  fontSize: 16)),
                          Expanded(
                            child: TextField(
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
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, // Background color
                      ),
                      onPressed: () {},
                      child: Text('add'.tr)),
                ],
              ),
            ],
          ),
        ),
      );
}

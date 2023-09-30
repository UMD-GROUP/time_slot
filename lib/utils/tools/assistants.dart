import 'package:time_slot/utils/tools/file_importers.dart';

// ignore: type_annotate_public_apis
double height(context) => MediaQuery.of(context).size.height;
// ignore: type_annotate_public_apis
double width(context) => MediaQuery.of(context).size.width;

String generateToken() {
  // Generate 5 random letters
  const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  final Random random = Random();
  String randomLetters = '';
  for (int i = 0; i < 5; i++) {
    // ignore: use_string_buffers
    randomLetters += letters[random.nextInt(letters.length)];
  }

  // Generate 3 random numbers
  const String numbers = '0123456789';
  String randomNumbers = '';
  for (int i = 0; i < 3; i++) {
    // ignore: use_string_buffers
    randomNumbers += numbers[random.nextInt(numbers.length)];
  }

  // ignore: prefer_single_quotes
  final String randomString = "$randomLetters$randomNumbers";

  return randomString.toUpperCase();
}

Future<void> postOrders({String? uid, String? referallId}) async {
  final List<Map<String, dynamic>> randomOrderJsonList = [];

  final Random random = Random();
  for (int i = 1; i <= 5; i++) {
    final OrderModel randomOrder = OrderModel(
      referallId: 'XOGOO712',
      ownerId: uid ?? 'DhuNGAJq6ZcZwOUEDm66XQFDFa03',
      orderId: random.nextInt(1000),
      productCount: random.nextInt(10) + 1,
      sum: double.parse((random.nextDouble() * 100).toStringAsFixed(2)),
      marketName: 'Market ${random.nextInt(5)}',
      dates: ['2023-09-30', '2023-10-01'],
      userPhoto: 'https://picsum.photos/200/300',
      status: OrderStatus.values[random.nextInt(OrderStatus.values.length)],
    );

    randomOrderJsonList.add(randomOrder.toJson());
  }

  final FirebaseFirestore instance = FirebaseFirestore.instance;

  for (final json in randomOrderJsonList) {
    await instance.collection('orders').add(json);
    print('Done');
  }
}

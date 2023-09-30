import 'package:time_slot/utils/tools/file_importers.dart';

double height(context) => MediaQuery.of(context).size.height;
double width(context) => MediaQuery.of(context).size.width;

String generateToken() {
  // Generate 5 random letters
  String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  Random random = Random();
  String randomLetters = "";
  for (int i = 0; i < 5; i++) {
    randomLetters += letters[random.nextInt(letters.length)];
  }

  // Generate 3 random numbers
  String numbers = "0123456789";
  String randomNumbers = "";
  for (int i = 0; i < 3; i++) {
    randomNumbers += numbers[random.nextInt(numbers.length)];
  }

  // Combine the letters and numbers into a random string
  String randomString = "$randomLetters$randomNumbers";

  return randomString.toUpperCase();
}

postOrders({String? uid, String? referallId}) async {
  // Generate random JSON objects for OrderModel
  List<Map<String, dynamic>> randomOrderJsonList = [];

  Random random = Random();
  for (int i = 1; i <= 5; i++) {
    OrderModel randomOrder = OrderModel(
      referallId: 'XOGOO712',
      ownerId: uid ?? 'DhuNGAJq6ZcZwOUEDm66XQFDFa03',
      orderId: random.nextInt(1000),
      productCount: random.nextInt(10) + 1,
      sum: double.parse((random.nextDouble() * 100).toStringAsFixed(2)),
      marketName: 'Market ${random.nextInt(5)}',
      dates: ['2023-09-30', '2023-10-01'],
      userPhoto: "https://picsum.photos/200/300",
      status: OrderStatus.values[random.nextInt(OrderStatus.values.length)],
    );

    randomOrderJsonList.add(randomOrder.toJson());
  }

  FirebaseFirestore instance = FirebaseFirestore.instance;

  for (var json in randomOrderJsonList) {
    await instance.collection('orders').add(json);
    print("Done");
  }
}

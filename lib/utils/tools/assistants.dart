// ignore_for_file: avoid_catches_without_on_clauses, type_annotate_public_apis, unnecessary_null_comparison

import 'dart:collection';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/delete_banner_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/user_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/price_input_dialog.dart';
import 'package:time_slot/ui/user/account/ui/widgets/add_banking_card_dialog.dart';
import 'package:time_slot/ui/user/account/ui/widgets/logout_dialog.dart';
import 'package:time_slot/ui/user/membership/ui/widget/add_purchase_dialog.dart';
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
      products: [],
      referallId: 'XOGOO712',
      ownerId: uid ?? 'DhuNGAJq6ZcZwOUEDm66XQFDFa03',
      orderId: random.nextInt(1000),
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

Future<String> uploadImageToFirebaseStorage(String imagePath) async {
  late String downloadURL;
  try {
    final FirebaseStorage storage = FirebaseStorage.instance;
    print(
        'images/${DateTime.now()}${Random().nextInt(1000)}.${imagePath.split('.')[1]}');
    final storageRef = storage.ref().child(
        'images/${DateTime.now()}${Random().nextInt(1000)}.${imagePath.split('.')[1]}');

    await storageRef.putFile(File(imagePath));
    downloadURL = await storageRef.getDownloadURL();
  } catch (e) {
    print('Error uploading image: $e');
  }
  return downloadURL;
}

String orderValidator(OrderModel order) {
  if (order.marketName.isEmpty) {
    return 'you_must_select_market'.tr;
  }
  if (order.dates.isEmpty) {
    return 'you_must_select_data'.tr;
  }
  if (order.products.isEmpty) {
    return 'you_must_add_product'.tr;
  }
  if (order.userPhoto.isEmpty) {
    return 'you_must_select_photo'.tr;
  }
  return '';
}

bool canNavigate(context, UserModel? user, DataFromAdminModel data) {
  String error = '';
  if (user == null) {
    error = 'try_again'.tr;
  }
  if (user!.markets.isEmpty) {
    error = 'you_need_to_create_market'.tr;
  }
  if (data.prices.length != 30 && data.deliveryNote.length != 6) {
    error = 'you_cant_create_order_now'.tr;
  }
  if (error.isNotEmpty) {
    AnimatedSnackBar(
            builder: (context) => AppErrorSnackBar(text: error),
            snackBarStrategy: RemoveSnackBarStrategy())
        .show(context);
    return false;
  }
  return true;
}

Future<void> postPurchases(String ownerId, String referralId) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Create a Firebase Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Generate and post 10 different PurchaseModel objects
  for (int i = 0; i < 10; i++) {
    final purchase = PurchaseModel(
      ownerId: ownerId,
      referralId: referralId,
      purchaseId: i,
      amount: 100.0 + i * 10.0,
      status: PurchaseStatus.values[i % 4], // Cycle through the enum values
    );

    // Convert the PurchaseModel to JSON
    final purchaseJson = purchase.toJson();

    try {
      // Post the PurchaseModel JSON data to Firestore
      await firestore.collection('purchases').add(purchaseJson);

      print('Purchase data $i posted to Firestore successfully!');
    } catch (e) {
      print('Error posting purchase data $i to Firestore: $e');
    }
  }
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Copied to clipboard: $text'),
    ),
  );
}

void showMoneyInputDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) =>
        AddPurchaseDialog(controller: TextEditingController()),
  );
}

void showAddBankingCardDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) =>
        AddBankingCardDialog(controller: TextEditingController()),
  );
}

void showLogOutDialog(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => const LogoutDialog(),
  );
}


void showOrderDialog(BuildContext context, UserModel userModel) {
  showCupertinoDialog(
    context: context,
    builder: (context) => UserDialog(user: userModel),
  );
}

void showDeleteDialog(BuildContext context, String image) {
  showCupertinoDialog(
    context: context,
    builder: (context) => DeleteBannerDialog(image: image),
  );
}

void showPriceInputDialog(BuildContext context, VoidCallback onDoneTap,
    TextEditingController controller) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (context) =>
        PriceInputDialog(priceController: controller, onDoneTap: onDoneTap),
  );
}

int generateRandomID(bool isOrder) {
  // Get the current date and time
  final DateTime now = DateTime.now();
  final int middleNumber = generateRandomNumber(isOrder);

  // Get the day and second components
  final int currentDay = now.day;
  final int currentSecond = now.second;

  // Generate 5 random numbers
  final Random random = Random();
  final List<int> randomDigits = List.generate(
      7 - (currentSecond.toString().length + currentDay.toString().length),
      (index) => random.nextInt(10));

  // Combine the components and random digits to create the ID
  final String id =
      '$currentDay$currentSecond$middleNumber${randomDigits.join()}';

  return int.parse(id);
}

int generateRandomNumber(bool isOdd) {
  final Random random = Random();
  int number = random.nextInt(9); // You can adjust the range as needed
  if (number.isOdd && isOdd) {
    number++; // Make sure it's an odd number
  }
  return number;
}

Future<void> postAdminData() async {
  final DataFromAdminModel data = DataFromAdminModel(
    banners: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRipGGPTs-IcBayNu-ulyxloogeyUVQaV0TnQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh7xkoaL6P4EvxEjdEyQoELJ1_yeymUd2ntQ&usqp=CAU',
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fdaryo.uz%2Fstatic%2F2023%2F06%2F6489641736aff.png&tbnid=a7MJEddpPNyIFM&vet=12ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhSegUIARCFAg..i&imgrefurl=https%3A%2F%2Fdaryo.uz%2F2023%2F06%2F14%2F16-uzum-market-oz-geografiyasini-kengaytirmoqda&docid=L9sgqjxhXJRuhM&w=1768&h=992&q=uzum%20market&ved=2ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhSegUIARCFAg',
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fstorage.kun.uz%2Fsource%2F9%2FIW9tYYvKjnLFsMRgINcrfnboO7WQpAZ0.jpg&tbnid=1ovC7kTBcZggPM&vet=12ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhIegUIARDtAQ..i&imgrefurl=https%3A%2F%2Fkun.uz%2Fuz%2Fnews%2F2022%2F12%2F28%2Fuzum-market-marketpleysida-elektronika-va-maishiy-texnikalarning-300-dan-ortiq-xalqaro-va-mahalliy-brendlari-taqdim-etilgan&docid=ACdpTEYnzdvjlM&w=1212&h=800&q=uzum%20market&ved=2ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhIegUIARDtAQ',
    ],
    deliveryNote: '123456',
    prices: List<int>.generate(30, (index) => index * 100),
    partnerPercent: 10.5,
  );

  final FirebaseFirestore instance = FirebaseFirestore.instance;
  await instance.collection('admin_data').add(data.toJson());
}

/// Example event class.
class Event {
  const Event(this.title);
  final String title;

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) =>
    key.day * 1000000 + key.month * 10000 + key.year;

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

String formatStringToMoney(String inputString) {
  // Parse the input string as a double
  final double amount = double.tryParse(inputString) ?? 0.0;

  // Create a NumberFormat instance to format as currency
  final moneyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '');

  // Format the double as currency and return the result
  return moneyFormatter.format(amount);
}

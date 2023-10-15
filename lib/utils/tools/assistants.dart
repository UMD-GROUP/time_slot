// ignore_for_file: avoid_catches_without_on_clauses, type_annotate_public_apis, unnecessary_null_comparison, non_constant_identifier_names, always_declare_return_types, library_private_types_in_public_api

import 'dart:collection';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/delete_banner_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/partner_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/price_input_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/purchase_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/user_dialog.dart';
import 'package:time_slot/ui/user/account/ui/widgets/add_banking_card_dialog.dart';
import 'package:time_slot/ui/user/account/ui/widgets/logout_dialog.dart';
import 'package:time_slot/ui/user/membership/ui/widget/add_purchase_dialog.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher.dart';

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
      finishedAt: DateTime.now(),
      createdAt: DateTime.now(),
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
  if (data.prices.length != 30 || data.deliveryNote.length != 6) {
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
      createdAt: DateTime.now(),
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

void showEditProductDialog(BuildContext context, ProductModel product,
    TextEditingController deliveryNote, TextEditingController count,
    {required VoidCallback onSaved}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => EditProductDialog(product,
        onSaved: onSaved, deliveryNote: deliveryNote, count: count),
  );
}

void showEditProductsBottomSheet(BuildContext context, OrderModel order) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => EditOderSheet(order: order),
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

void showUserPopUp(BuildContext context, UserModel userModel) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => Theme(
        data: AdaptiveTheme.of(context).theme.backgroundColor == Colors.white
            ? ThemeData.light()
            : ThemeData.dark(),
        child: UserInfoPopUp(user: userModel)),
  );
}

void showPartnerDialog(BuildContext context, UserModel userModel) {
  showCupertinoDialog(
    context: context,
    builder: (context) => Theme(
        data: AdaptiveTheme.of(context).theme.backgroundColor == Colors.white
            ? ThemeData.light()
            : ThemeData.dark(),
        child: PartnerDialog(user: userModel)),
  );
}

void showPurchaseDialog(BuildContext context, PurchaseModel purchaseModel) {
  showCupertinoDialog(
    context: context,
    builder: (context) => Theme(
        data: AdaptiveTheme.of(context).theme.backgroundColor == Colors.white
            ? ThemeData.light()
            : ThemeData.dark(),
        child: PurchaseDialog(purchaseModel: purchaseModel)),
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

void showNumberInputDialog(BuildContext context,
    {required VoidCallback onConfirmTapped,
    required TextEditingController controller,
    required TextInputFormatter inputFormatter,
    required String title,
    required String hintText}) {
  showCupertinoModalPopup<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) => NumberInputDialog(
        inputFormatter: inputFormatter,
        controller: controller,
        onConfirmTapped: onConfirmTapped,
        title: title,
        hintText: hintText),
  );
}

void showTextInputDialog(BuildContext context,
    {required VoidCallback onConfirmTapped,
    required TextEditingController controller,
    required String title,
    required String hintText}) {
  showCupertinoModalPopup<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) => TextInputDialog(
        controller: controller,
        onConfirmTapped: onConfirmTapped,
        title: title,
        hintText: hintText),
  );
}

void showConfirmCancelDialog(BuildContext context, VoidCallback onConfirmTap) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CancelConfirmDialog(onConfirmTap: onConfirmTap),
  );
}

void showAdminPasswordDialog(
    BuildContext context, TextEditingController controller) {
  showCupertinoDialog(
    context: context,
    builder: (context) => AdminPanelPasswordDialog(
        controller: controller,
        password: context.read<DataFromAdminBloc>().state.data!.adminPassword),
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
  // final DataFromAdminModel data = DataFromAdminModel(
  //   banners: [
  //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRipGGPTs-IcBayNu-ulyxloogeyUVQaV0TnQ&usqp=CAU',
  //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh7xkoaL6P4EvxEjdEyQoELJ1_yeymUd2ntQ&usqp=CAU',
  //     'https://www.google.com/imgres?imgurl=https%3A%2F%2Fdaryo.uz%2Fstatic%2F2023%2F06%2F6489641736aff.png&tbnid=a7MJEddpPNyIFM&vet=12ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhSegUIARCFAg..i&imgrefurl=https%3A%2F%2Fdaryo.uz%2F2023%2F06%2F14%2F16-uzum-market-oz-geografiyasini-kengaytirmoqda&docid=L9sgqjxhXJRuhM&w=1768&h=992&q=uzum%20market&ved=2ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhSegUIARCFAg',
  //     'https://www.google.com/imgres?imgurl=https%3A%2F%2Fstorage.kun.uz%2Fsource%2F9%2FIW9tYYvKjnLFsMRgINcrfnboO7WQpAZ0.jpg&tbnid=1ovC7kTBcZggPM&vet=12ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhIegUIARDtAQ..i&imgrefurl=https%3A%2F%2Fkun.uz%2Fuz%2Fnews%2F2022%2F12%2F28%2Fuzum-market-marketpleysida-elektronika-va-maishiy-texnikalarning-300-dan-ortiq-xalqaro-va-mahalliy-brendlari-taqdim-etilgan&docid=ACdpTEYnzdvjlM&w=1212&h=800&q=uzum%20market&ved=2ahUKEwiVnvq89NmBAxUNBxAIHar4Bu8QMyhIegUIARDtAQ',
  //   ],
  //   deliveryNote: '123456',
  //   prices: List<int>.generate(30, (index) => index * 100),
  //   partnerPercent: 10.5,
  // );
  //
  // final FirebaseFirestore instance = FirebaseFirestore.instance;
  // await instance.collection('admin_data').add(data.toJson());
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

class NumberInputDialog extends StatelessWidget {
  NumberInputDialog(
      {required this.controller,
      required this.title,
      required this.inputFormatter,
      required this.hintText,
      required this.onConfirmTapped,
      super.key});
  String title;
  String hintText;
  VoidCallback onConfirmTapped;
  TextEditingController controller = TextEditingController();
  TextInputFormatter inputFormatter;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: <Widget>[
            CupertinoTextField(
              inputFormatters: [inputFormatter],
              controller: controller,
              placeholder: hintText,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onConfirmTapped,
            child: Text('confirm'.tr),
          ),
        ],
      );
}

class TextInputDialog extends StatelessWidget {
  TextInputDialog(
      {required this.controller,
      required this.title,
      required this.hintText,
      required this.onConfirmTapped,
      super.key});
  String title;
  String hintText;
  VoidCallback onConfirmTapped;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: <Widget>[
            CupertinoTextField(
              controller: controller,
              placeholder: hintText,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onConfirmTapped,
            child: Text('confirm'.tr),
          ),
        ],
      );
}

class CancelConfirmDialog extends StatelessWidget {
  CancelConfirmDialog({required this.onConfirmTap, super.key});

  VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('confirming'.tr),
        content: Text('are_you_sure_to_confirm_this_action'.tr),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          CupertinoDialogAction(
            onPressed: onConfirmTap,
            child: Text('confirm'.tr),
          ),
        ],
      );
}

class AdminPanelPasswordDialog extends StatelessWidget {
  AdminPanelPasswordDialog(
      {required this.password, required this.controller, super.key});
  TextEditingController controller;
  String password;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('admin_panel'.tr),
        content: Column(
          children: [
            Text('you_will_be_blocked'.tr,
                style: AppTextStyles.labelLarge(context, color: Colors.black)),
            CupertinoTextField(
              controller: controller,
              autofocus: true,
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('confirm'.tr),
            onPressed: () {
              // You can handle the PIN entered here
              if (controller.text.trim() == password) {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RouteName.adminHome);
              } else {
                controller.clear();
                AnimatedSnackBar(
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  duration: const Duration(seconds: 4),
                  builder: (context) =>
                      AppErrorSnackBar(text: 'wrong_password'.tr),
                ).show(context);
              }
            },
          ),
        ],
      );
}

class EditOderSheet extends StatefulWidget {
  EditOderSheet({required this.order, super.key});
  OrderModel order;

  @override
  State<EditOderSheet> createState() => _EditOderSheetState();
}

class _EditOderSheetState extends State<EditOderSheet> {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: AdaptiveTheme.of(context).theme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: ListView.builder(
          itemCount: widget.order.products.length,
          itemBuilder: (context, index) {
            final item = widget.order.products[index];

            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width(context) * 0.7,
                    child: ListTile(
                      title: Text(
                        item.deliveryNote,
                        style: AppTextStyles.labelLarge(context, fontSize: 18),
                      ),
                      subtitle: Text(
                        item.count.toString(),
                        style: AppTextStyles.labelLarge(context, fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: AdaptiveTheme.of(context).theme.hintColor,
                          ),
                          onPressed: () {
                            final TextEditingController deliveryNote =
                                TextEditingController()
                                  ..text = item.deliveryNote.split(' ').last;

                            final TextEditingController count =
                                TextEditingController()
                                  ..text = item.count.toString();

                            showEditProductDialog(
                              context,
                              item,
                              deliveryNote,
                              count,
                              onSaved: () {
                                final String note =
                                    item.deliveryNote.split(' ').first;
                                item
                                  ..deliveryNote =
                                      '$note ${deliveryNote.text.trim()}'
                                  ..count = int.parse(count.text.trim());
                                setState(() {});
                                widget.order.sum = context
                                        .read<DataFromAdminBloc>()
                                        .state
                                        .data!
                                        .prices[widget.order.dates.length - 1] *
                                    widget.order.products.fold(
                                        0,
                                        (previousValue, element) => int.parse(
                                            (previousValue + element.count)
                                                .toString()));
                                Navigator.pop(context);
                              },
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            widget.order.products.remove(item);
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 20.h)
                      ],
                    ),
                  )
                ]);
          },
        ),
      );
}

class EditProductDialog extends StatefulWidget {
  EditProductDialog(this.product,
      {required this.deliveryNote,
      required this.onSaved,
      required this.count,
      super.key});
  TextEditingController deliveryNote;
  TextEditingController count;
  ProductModel product;
  VoidCallback onSaved;

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: const Text('Enter Numbers'),
        content: Column(
          children: [
            SizedBox(height: height(context) * 0.02),
            SizedBox(
              width: width(context) * 0.5,
              child: CupertinoTextField(
                controller: widget.deliveryNote,
                keyboardType: TextInputType.number,
                maxLength: 7, // Maximum of 7 numbers
                placeholder: 'Enter up to 7 numbers',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            SizedBox(
              width: width(context) * 0.3,
              child: CupertinoTextField(
                controller: widget.count,
                keyboardType: TextInputType.number,
                maxLength: 3, // Maximum of 3 numbers
                placeholder: 'Enter up to 3 numbers',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
              onPressed: widget.onSaved, child: Text('confirm'.tr)),
        ],
      );
}

Future<void> launch(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

String dateTimeToFormat(DateTime time) =>
    '${time.day}.${time.month}.${time.year} ${time.hour >= 10 ? time.hour : '0${time.hour}'}:${time.minute >= 10 ? time.minute : '0${time.minute}'}';

Future<User?> handleSignIn() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  } catch (error) {
    return null;
  }
}

class YouTubeVideo extends StatefulWidget {
  YouTubeVideo(this.videoUrl, {super.key});
  String videoUrl;

  @override
  State<YouTubeVideo> createState() => _YouTubeVideoState();
}

class _YouTubeVideoState extends State<YouTubeVideo> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      CustomVideoPlayerSettings(
          durationAfterControlsFadeOut: const Duration(seconds: 1),
          alwaysShowThumbnailOnVideoPaused: true,
          thumbnailWidget: Image.network(
            'https://www.spot.uz/media/img/2022/08/85brvW16603795118030_b.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
          ));

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController3 = VideoPlayerController.network(widget.videoUrl);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        '240p': _videoPlayerController2,
        '480p': _videoPlayerController3,
        '720p': _videoPlayerController,
      },
    );

    // _customVideoPlayerWebController = CustomVideoPlayerWebController(
    //   webVideoPlayerSettings: _customVideoPlayerWebSettings,
    // );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('instruction'.tr),
        ),
        child: Center(
          child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController,
          ),
        ),
      );
}

void showVideoPlayer(context, videoUrl) {
  showCupertinoDialog(
    context: context,
    builder: (context) => YouTubeVideo(
      videoUrl,
    ),
  );
}

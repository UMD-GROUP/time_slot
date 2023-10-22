// ignore_for_file: avoid_catches_without_on_clauses, type_annotate_public_apis, unnecessary_null_comparison, non_constant_identifier_names, always_declare_return_types, library_private_types_in_public_api, prefer_expression_function_bodies, cascade_invocations, use_string_buffers

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_slot/service/storage_service/storage_service.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/create_promo_code_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/delete_banner_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/price_input_dialog.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/user_dialog.dart';
import 'package:time_slot/ui/user/account/ui/widgets/logout_dialog.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

double height(context) => MediaQuery.of(context).size.height;
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

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Copied to clipboard: $text'),
    ),
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

// void showAddBankingCardDialog(BuildContext context) {
//   showCupertinoDialog(
//     context: context,
//     builder: (context) =>
//         AddBankingCardDialog(controller: TextEditingController()),
//   );
// }

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

void showCreatePromoCodeDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (context) => CreatePromoCodeDialog(
        amount: TextEditingController(), discount: TextEditingController()),
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
              keyboardType: TextInputType.text,
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

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget(this.videoUrl, {super.key});
  String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
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
    builder: (context) => VideoPlayerWidget(
      videoUrl,
    ),
  );
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// #enddocregion platform_imports

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          context.read<DataFromAdminBloc>().state.data!.termsOfUsing));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          middle: Text('terms_of_using'.tr,
              style: AppTextStyles.labelLarge(context)),
        ),
        child: SafeArea(child: WebViewWidget(controller: _controller)),
      );
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
  logExample,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) => PopupMenuButton<MenuOptions>(
        key: const ValueKey<String>('ShowPopupMenu'),
        onSelected: (value) {
          switch (value) {
            case MenuOptions.showUserAgent:
              _onShowUserAgent();
              break;
            case MenuOptions.listCookies:
              _onListCookies(context);
              break;
            case MenuOptions.clearCookies:
              _onClearCookies(context);
              break;
            case MenuOptions.addToCache:
              _onAddToCache(context);
              break;
            case MenuOptions.listCache:
              _onListCache();
              break;
            case MenuOptions.clearCache:
              _onClearCache(context);
              break;
            case MenuOptions.navigationDelegate:
              // _onNavigationDelegateExample();
              break;
            case MenuOptions.doPostRequest:
              _onDoPostRequest();
              break;
            case MenuOptions.loadLocalFile:
              _onLoadLocalFileExample();
              break;
            case MenuOptions.loadFlutterAsset:
              // _onLoadFlutterAssetExample();
              break;
            case MenuOptions.loadHtmlString:
              // _onLoadHtmlStringExample();
              break;
            case MenuOptions.transparentBackground:
              // _onTransparentBackground();
              break;
            case MenuOptions.setCookie:
              _onSetCookie();
              break;
            case MenuOptions.logExample:
              // _onLogExample();
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuItem<MenuOptions>>[
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.showUserAgent,
            child: Text('Show user agent'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.listCookies,
            child: Text('List cookies'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.clearCookies,
            child: Text('Clear cookies'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.addToCache,
            child: Text('Add to cache'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.listCache,
            child: Text('List cache'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.clearCache,
            child: Text('Clear cache'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.navigationDelegate,
            child: Text('Navigation Delegate example'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.doPostRequest,
            child: Text('Post Request'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.loadHtmlString,
            child: Text('Load HTML string'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.loadLocalFile,
            child: Text('Load local file'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.loadFlutterAsset,
            child: Text('Load Flutter Asset'),
          ),
          const PopupMenuItem<MenuOptions>(
            key: ValueKey<String>('ShowTransparentBackgroundExample'),
            value: MenuOptions.transparentBackground,
            child: Text('Transparent background example'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.setCookie,
            child: Text('Set cookie'),
          ),
          const PopupMenuItem<MenuOptions>(
            value: MenuOptions.logExample,
            child: Text('Log example'),
          ),
        ],
      );

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return webViewController.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Cookies:'),
            _getCookieList(cookies),
          ],
        ),
      ));
    }
  }

  Future<void> _onAddToCache(BuildContext context) async {
    await webViewController.runJavaScript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added a test entry to cache.'),
      ));
    }
  }

  Future<void> _onListCache() => webViewController.runJavaScript('caches.keys()'
      // ignore: missing_whitespace_between_adjacent_strings
      '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
      '.then((caches) => Toaster.postMessage(caches))');

  Future<void> _onClearCache(BuildContext context) async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cache cleared.'),
      ));
    }
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  // Future<void> _onNavigationDelegateExample() {
  //   final String contentBase64 = base64Encode(
  //     const Utf8Encoder().convert(kNavigationExamplePage),
  //   );
  //   return webViewController.loadRequest(
  //     Uri.parse('data:text/html;base64,$contentBase64'),
  //   );
  // }

  Future<void> _onSetCookie() async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'foo',
        value: 'bar',
        domain: 'httpbin.org',
        path: '/anything',
      ),
    );
    await webViewController.loadRequest(Uri.parse(
      'https://httpbin.org/anything',
    ));
  }

  Future<void> _onDoPostRequest() => webViewController.loadRequest(
        Uri.parse('https://httpbin.org/post'),
        method: LoadRequestMethod.post,
        headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
        body: Uint8List.fromList('Test Body'.codeUnits),
      );

  Future<void> _onLoadLocalFileExample() async {
    final String pathToIndex = await _prepareLocalFile();
    await webViewController.loadFile(pathToIndex);
  }

  // Future<void> _onLoadFlutterAssetExample() =>
  //     webViewController.loadFlutterAsset('assets/www/index.html');
  //
  // Future<void> _onLoadHtmlStringExample() =>
  //     webViewController.loadHtmlString(kLocalExamplePage);
  //
  // Future<void> _onTransparentBackground() =>
  //     webViewController.loadHtmlString(kTransparentBackgroundPage);

  Widget _getCookieList(String cookies) {
    if (cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  static Future<String> _prepareLocalFile() async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(
        <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    // await indexFile.writeAsString(kLocalExamplePage);

    return indexFile.path;
  }

  // Future<void> _onLogExample() {
  //   webViewController.setOnConsoleMessage((consoleMessage) {
  //     debugPrint(
  //         '== JS == ${consoleMessage.level.name}: ${consoleMessage.message}');
  //   });
  //
  //   return webViewController.loadHtmlString(kLogExamplePage);
  // }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await webViewController.canGoBack()) {
                await webViewController.goBack();
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (await webViewController.canGoForward()) {
                await webViewController.goForward();
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () => webViewController.reload(),
          ),
        ],
      );
}

bool canTapStep(context, OrderModel order, int step) {
  String error = '';
  if (step == 1 && order.marketName.isEmpty) {
    error = 'you_must_select_market'.tr;
  }
  if (step == 2 && order.dates.isEmpty) {
    error = 'you_must_select_data'.tr;
  }
  if (step == 3 && order.products.isEmpty) {
    error = 'you_must_add_product'.tr;
  }

  if (error.isNotEmpty) {
    AnimatedSnackBar(
      snackBarStrategy: RemoveSnackBarStrategy(),
      duration: const Duration(seconds: 4),
      builder: (context) => AppErrorSnackBar(text: error),
    ).show(context);
  }
  return error.isEmpty;
}

void changeLanguage() {
  final bool isUzbek = 'light_mode'.tr == 'Kunduzgi rejim';
  Get.updateLocale(
      isUzbek ? const Locale('ru', 'RU') : const Locale('uz', 'UZ'));
  print(isUzbek);
  StorageService().saveString('language', isUzbek ? 'ru' : 'uz');
}

String generateUniquePromoCode(List<PromoCodeModel> existingPromoCodes) {
  const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random random = Random();
  String promoCode = '';

  do {
    promoCode = '';
    for (int i = 0; i < 7; i++) {
      final int randomIndex = random.nextInt(charset.length);
      promoCode += charset[randomIndex];
    }
  } while (existingPromoCodes.any((promo) => promo.promoCode == promoCode));

  return promoCode;
}

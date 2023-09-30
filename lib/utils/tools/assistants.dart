import 'dart:math';

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

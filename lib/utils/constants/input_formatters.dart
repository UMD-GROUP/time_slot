// ignore_for_file: parameter_assignments

import 'package:flutter/services.dart';

class MyTextInputFormatter extends FilteringTextInputFormatter {
  MyTextInputFormatter() : super.allow(RegExp(r'[a-zA-Z\s]'));
}

class NoNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredValue = newValue.text.replaceAll(RegExp('[0-9]'), '');

    return newValue.copyWith(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}

class ThreeDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any characters that are not digits (0-9)
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // Limit the input to a maximum of 4 digits
    if (newText.length > 3) {
      return oldValue;
    }

    // Return the formatted input
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class SevenDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any characters that are not digits (0-9)
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // Limit the input to a maximum of 4 digits
    if (newText.length > 7) {
      return oldValue;
    }

    // Return the formatted input
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final numericValue =
        int.tryParse(newValue.text.replaceAll(' ', '')); // Remove spaces

    if (numericValue != null) {
      final formattedValue = _formatNumber(numericValue);
      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    return newValue;
  }

  String _formatNumber(int value) {
    final String stringValue = value.toString();
    final int length = stringValue.length;
    final List<String> parts = [];

    for (var i = 0; i < length; i += 3) {
      final start = length - i - 3;
      final end = length - i;
      if (start < 0) {
        parts.insert(0, stringValue.substring(0, end));
      } else {
        parts.insert(0, stringValue.substring(start, end));
      }
    }

    return parts.join(' ');
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formatted = _formatCardNumber(newValue.text);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCardNumber(String input) {
    input = input.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    if (input.length > 16) {
      input = input.substring(0, 16); // Truncate to 16 characters
    }
    final List<String> parts = [];
    for (int i = 0; i < input.length; i += 4) {
      parts.add(input.substring(i, i + 4));
    }
    return parts.join(' ');
  }
}

class DeliveryNoteInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use a regular expression to allow only digits (0-9)
    final RegExp regex = RegExp('[0-9]');

    // Filter out any non-numeric characters and limit to 6 characters
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    final result = newText.length > 6 ? newText.substring(0, 6) : newText;

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class MemberPercentInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use a regular expression to allow only digits (0-9)
    final RegExp regex = RegExp('[0-9]');

    // Filter out any non-numeric characters and limit to 6 characters
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    final result = newText.length > 2 ? newText.substring(0, 2) : newText;

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

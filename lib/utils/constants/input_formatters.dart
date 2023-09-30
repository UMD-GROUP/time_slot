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

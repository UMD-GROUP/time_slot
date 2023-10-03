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
    if (newValue.selection.baseOffset == 0) {
      // Ensure that a digit is always at the beginning of the text.
      return newValue.copyWith(
        text: '0 ${_format(newValue.text)}',
        selection: const TextSelection.collapsed(offset: 2),
      );
    } else {
      return newValue.copyWith(
        text: _format(newValue.text),
        selection: TextSelection.collapsed(
          offset: _format(newValue.text).length,
        ),
      );
    }
  }

  String _format(String text) {
    final numericOnly = text.replaceAll(RegExp('[^0-9]'), '');
    final formatted = StringBuffer();
    final int startFrom = text.length % 4 == 0
        ? 2
        : text.length % 5 == 0
            ? 3
            : 0;

    for (var i = startFrom; i < numericOnly.length; i++) {
      if (i != 0 && i % 3 == 0) {
        formatted.write(' ');
      }
      formatted.write(numericOnly[i]);
    }
    return formatted.toString();
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

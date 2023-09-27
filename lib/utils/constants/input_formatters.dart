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
    final filteredValue = newValue.text.replaceAll(RegExp(r'[0-9]'), '');

    return newValue.copyWith(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}

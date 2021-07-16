import 'package:flutter/services.dart';

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text
        .replaceAll(new RegExp(r'[^0-9]'), '')
        .replaceAll(new RegExp(r'^0+'), '');
    while (text.length < 3) {
      text = '0' + text;
    }
    text = text.substring(0, text.length - 2) +
        ',' +
        text.substring(text.length - 2);
    return TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: text.length,
        ),
      ),
    );
  }
}

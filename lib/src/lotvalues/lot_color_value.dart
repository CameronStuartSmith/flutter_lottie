import 'package:flutter/material.dart';
import 'lot_value.dart';

class LOTColorValue extends LOTValue {
  Color _value;

  LOTColorValue.fromHEX({ @required String hex }) {
    _value = HexColor(hex);
  }

  LOTColorValue.fromColor({ @required Color color }) {
    _value = color;
  }

  String get value {
    return '0x${_value.value.toRadixString(16).padLeft(8, '0')}';
  }

  String get type {
    return 'LOTColorValue';
  }

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
// layout_map.dart
import 'package:flutter/material.dart';
import 'Layout_48.dart';
import 'Layout_44.dart';
// import 'Layout_60.dart';

typedef LayoutBuilderFunc =
    Widget Function({
      required Widget Function(String seat, bool isSleeper) buildSeat,
    });

final Map<String, LayoutBuilderFunc> seatLayoutMap = {
  "L001": ({required buildSeat}) => Layout48(buildSeat: buildSeat),
  "L002": ({required buildSeat}) => Layout44(buildSeat: buildSeat),
  // "LAYOUT60": ({required buildSeat}) => Layout60(buildSeat: buildSeat),
};

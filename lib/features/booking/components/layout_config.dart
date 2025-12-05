// layout_config.dart
import 'package:flutter/material.dart';

import 'layout_44_2x1.dart';
import 'layout_48_2x1.dart';
import 'layout_60_2x2.dart';

enum SeatType { seater, sleeper, mixed }

class BusLayout {
  final String id;
  final String name;
  final SeatType type;
  final int capacity;
  final String description;
  final Widget Function(BuildContext) layoutBuilder;

  const BusLayout({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.description,
    required this.layoutBuilder,
  });
}

final Map<String, BusLayout> busLayouts = {
  "L001": BusLayout(
    id: "L001",
    name: "48 Capacity (2+1) Seat/Sleeper",
    type: SeatType.mixed,
    capacity: 48,
    description:
        "Left upper/lower sleepers, middle seaters, right double sleepers (Volvo 2+1).",
    layoutBuilder: (context) => const Layout_48_2x1(),
  ),
  // "L002": BusLayout(
  //   id: "L002",
  //   name: "44 Capacity (2+1) Seat/Sleeper",
  //   type: SeatType.mixed,
  //   capacity: 44,
  //   description: "Slightly fewer sleepers — used for premium 2+1 mixed layout.",
  //   layoutBuilder: (context) => const Layout_44_2x1(),
  // ),
  // "L003": BusLayout(
  //   id: "L003",
  //   name: "60 Capacity (2+2) Seat/Sleeper",
  //   type: SeatType.mixed,
  //   capacity: 60,
  //   description: "2+2 AC seater/sleeper hybrid — used in semi-sleeper buses.",
  //   layoutBuilder: (context) => const Layout_60_2x2(),
  // ),
};

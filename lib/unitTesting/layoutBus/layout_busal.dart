import 'bus_layouts.dart';

enum LayoutType { layout48, layout44, layout60 }

final Map<LayoutType, String> layoutNames = {
  LayoutType.layout48: "48 Capacity (2+1) Seat/Sleeper",
  LayoutType.layout44: "44 Capacity (2+1) Seat/Sleeper",
  LayoutType.layout60: "60 Capacity (2+2) Seat/Sleeper",
};

class SeatPricing {
  final double seatPrice; // S
  final double doubleSleeperPrice; // DSL/DSU
  final double singleSleeperPrice; // SL/SU

  SeatPricing({
    required this.seatPrice,
    required this.doubleSleeperPrice,
    required this.singleSleeperPrice,
  });
}

class BusModel {
  final String busName;
  final LayoutType layoutType;
  final int totalSeats;
  final SeatPricing pricing;

  BusModel({
    required this.busName,
    required this.layoutType,
    required this.totalSeats,
    required this.pricing,
  });
}

class SeatModel {
  final String id; // e.g., "SU1", "1", "DU4"
  final double price;
  final bool isAvailable;
  final String type; // e.g., "SU", "SL", "DU", "DL", etc.
  final int row;
  final int col;

  SeatModel({
    required this.id,
    required this.price,
    required this.isAvailable,
    required this.type,
    required this.row,
    required this.col,
  });
}

final Map<LayoutType, List<SeatModel>> seatLayouts = {
  LayoutType.layout48: layout48Data,
  LayoutType.layout44: layout44Data,
  LayoutType.layout60: layout60Data,
};

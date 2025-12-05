import 'layout_busal.dart';

// 48 Capacity (2+1) Seat/Sleeper Layout
final List<SeatModel> layout48Data = [
  // ---------- LOWER DECK ----------
  // Left side (Single Sleepers - SU/SL)
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'SU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'SU',
      row: i,
      col: 0,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'SL${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'SL',
      row: i,
      col: 1,
    ),
  ),

  // Right side (Seats - S)
  ...List.generate(
    6,
    (i) => SeatModel(
      id: '${i * 2 + 1}',
      price: 0,
      isAvailable: true,
      type: 'S',
      row: i,
      col: 3,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: '${i * 2 + 2}',
      price: 0,
      isAvailable: true,
      type: 'S',
      row: i,
      col: 4,
    ),
  ),

  // Right side (Double Sleepers - DSU/DSL)
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'DSU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'DSU',
      row: i,
      col: 5,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'DSL${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'DSL',
      row: i,
      col: 6,
    ),
  ),

  // ---------- UPPER DECK ----------
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'SUU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'SU',
      row: i + 7,
      col: 0,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'SLU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'SL',
      row: i + 7,
      col: 1,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'S${i * 2 + 13}',
      price: 0,
      isAvailable: true,
      type: 'S',
      row: i + 7,
      col: 3,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'S${i * 2 + 14}',
      price: 0,
      isAvailable: true,
      type: 'S',
      row: i + 7,
      col: 4,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'DSUU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'DSU',
      row: i + 7,
      col: 5,
    ),
  ),
  ...List.generate(
    6,
    (i) => SeatModel(
      id: 'DSLU${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'DSL',
      row: i + 7,
      col: 6,
    ),
  ),
];

// 44 Capacity (2+1)
final List<SeatModel> layout44Data = [
  ...List.generate(
    11,
    (i) => SeatModel(
      id: 'S${i + 1}',
      price: 0,
      isAvailable: true,
      type: 'S',
      row: i,
      col: (i % 2 == 0) ? 0 : 2,
    ),
  ),
];

// 60 Capacity (2+2)
final List<SeatModel> layout60Data = [
  for (int r = 0; r < 10; r++)
    for (int c = 0; c < 4; c++)
      SeatModel(
        id: 'S${r * 4 + c + 1}',
        price: 0,
        isAvailable: true,
        type: 'S',
        row: r,
        col: c,
      ),
];

// Registry linking layouts
final Map<LayoutType, List<SeatModel>> seatLayouts = {
  LayoutType.layout48: layout48Data,
  LayoutType.layout44: layout44Data,
  LayoutType.layout60: layout60Data,
};

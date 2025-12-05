/// Enum representing different types of bus seats
enum SeatType {
  s('S', 'Regular Seat'),
  dsl('DSL', 'Double Sleeper Lower'),
  dsu('DSU', 'Double Sleeper Upper'),
  sl('SL', 'Single Sleeper Lower'),
  su('SU', 'Single Sleeper Upper');

  final String code;
  final String label;

  const SeatType(this.code, this.label);

  /// Get all seat types for dropdown
  static List<SeatType> get allTypes => SeatType.values;

  /// Get display string for UI
  String get displayName => '$code - $label';

  /// Parse string to SeatType
  static SeatType? fromCode(String code) {
    try {
      return SeatType.values.firstWhere((e) => e.code == code);
    } catch (e) {
      return null;
    }
  }
}

/// Model to represent a configured seat type with price and quantity
class SeatTypeConfig {
  final SeatType type;
  final int quantity;
  final double price;
  final bool isConfirmed;

  SeatTypeConfig({
    required this.type,
    required this.quantity,
    required this.price,
    this.isConfirmed = false,
  });

  /// Total value of this seat type (quantity × price)
  double get totalValue => quantity * price;

  /// Copy with method
  SeatTypeConfig copyWith({
    SeatType? type,
    int? quantity,
    double? price,
    bool? isConfirmed,
  }) {
    return SeatTypeConfig(
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  @override
  String toString() =>
      '$type: $quantity seats @ ₹$price = ₹${totalValue.toStringAsFixed(2)}';
}

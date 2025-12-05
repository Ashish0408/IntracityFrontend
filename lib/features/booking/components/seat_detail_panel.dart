import 'package:flutter/material.dart';

/// Displays details for a selected seat including price, amenities, and booking info.
class SeatDetailPanel extends StatelessWidget {
  final String? selectedSeat;
  final String? seatPrice;
  final String seatType; // e.g., "Seater", "Sleeper", "Window", etc.
  final List<String> selectedSeats;
  final Map<String, String>
  seatPrices; // Map seat ID to price for total calculation
  final VoidCallback? onConfirmBooking;

  const SeatDetailPanel({
    super.key,
    this.selectedSeat,
    this.seatPrice,
    this.seatType = 'Standard',
    this.selectedSeats = const [],
    this.seatPrices = const {},
    this.onConfirmBooking,
  });

  double calculateTotal() {
    double total = 0;
    for (final seat in selectedSeats) {
      final price = seatPrices[seat];
      if (price != null) {
        total += double.tryParse(price.replaceAll(RegExp('[^0-9.]'), '')) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotal();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Seat Details',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.white24, height: 24),

            // Selected Seat Info
            if (selectedSeat != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('Selected Seat:', selectedSeat!, context),
                  const SizedBox(height: 12),
                  _infoRow('Seat Type:', seatType, context),
                  const SizedBox(height: 12),
                  _infoRow('Price:', seatPrice ?? '-', context, isPrice: true),
                  const SizedBox(height: 20),
                  // Amenities
                  Text(
                    'Amenities:',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _amenityTag('WiFi'),
                      _amenityTag('USB Charging'),
                      _amenityTag('Blanket'),
                      _amenityTag('Pillow'),
                    ],
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Select a seat to view details',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.white54),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Selected Seats Summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Summary',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    'Selected Seats:',
                    selectedSeats.isNotEmpty
                        ? selectedSeats.join(', ')
                        : 'None',
                    context,
                  ),
                  const SizedBox(height: 8),
                  _infoRow('Seat Count:', '${selectedSeats.length}', context),
                  const Divider(color: Colors.white24, height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Fare:',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '₹${total.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Confirm Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedSeats.isNotEmpty ? onConfirmBooking : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.greenAccent,
                  disabledBackgroundColor: Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirm Booking',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: selectedSeats.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value,
    BuildContext context, {
    bool isPrice = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isPrice ? Colors.greenAccent : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _amenityTag(String amenity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
      ),
      child: Text(
        amenity,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

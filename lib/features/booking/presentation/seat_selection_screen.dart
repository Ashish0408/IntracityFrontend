import 'package:flutter/material.dart';
import 'dart:developer';

import '../components/layout_config.dart';
import '../components/layout_44_2x1.dart';
import '../services/seat_service.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String busId;
  final String layoutId;

  const SeatSelectionScreen({
    super.key,
    required this.busId,
    required this.layoutId,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Set<String> selectedSeats = {};
  bool isLoading = true;
  bool isLocking = false;
  List<String> bookedSeats = [];
  String userGender = 'O'; // Default to 'Other'

  @override
  void initState() {
    super.initState();
    _loadBookingData();
  }

  Future<void> _loadBookingData() async {
    try {
      // Load seat prices
      final prices = await SeatService.getBusSeatPrices(widget.busId);
      if (prices.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load seat prices')),
          );
        }
      }

      // Load booked seats
      final booked = await SeatService.getBookedSeats(
        busId: widget.busId,
        layoutId: widget.layoutId,
      );

      // Load user gender (for seat restrictions)
      const userId = 'user-123'; // TODO: Get from auth provider
      final gender = await SeatService.getUserGender(userId: userId);

      if (mounted) {
        setState(() {
          bookedSeats = booked;
          userGender = gender;
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading booking data: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onNext() async {
    if (selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one seat')),
      );
      return;
    }

    setState(() {
      isLocking = true;
    });

    // TODO: Get actual userId from auth provider
    const userId = 'user-123';

    final success = await SeatService.lockSeats(
      busId: widget.busId,
      selectedSeats: selectedSeats.toList(),
      userId: userId,
      lockDurationMinutes: 3,
    );

    setState(() {
      isLocking = false;
    });

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '✅ Seats locked! You have 3 minutes to complete booking',
            ),
          ),
        );
        // TODO: Navigate to payment/confirmation screen
        // context.beamToNamed('/booking/confirm');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Failed to lock seats. Try again')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = busLayouts[widget.layoutId];
    if (layout == null) {
      return const Center(child: Text("Unknown layout"));
    }

    if (isLoading) {
      return Container(
        color: Colors.black87,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Text(
                'Select Your Seat',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Seat Grid
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLayoutWithCallbacks(layout),
                    const SizedBox(height: 16),
                    _buildSeatLegend(context),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Selected Seats Info + Next Button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Seats:',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.white70),
                        ),
                        Text(
                          selectedSeats.isNotEmpty
                              ? selectedSeats.join(', ')
                              : 'None',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLocking ? null : _onNext,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.greenAccent,
                          disabledBackgroundColor: Colors.grey.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLocking
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey.shade700,
                                  ),
                                ),
                              )
                            : Text(
                                'Next',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLayoutWithCallbacks(BusLayout layout) {
    if (widget.layoutId == 'L001' || widget.layoutId == 'L002') {
      return Layout_44_2x1(
        selectedSeats: selectedSeats,
        bookedSeats: bookedSeats,
        userGender: userGender,
        onSeatsChanged: (seats) {
          setState(() {
            selectedSeats = seats;
          });
        },
      );
    }
    return layout.layoutBuilder(context);
  }

  Widget _buildSeatLegend(BuildContext context) {
    final legendItems = [
      _legendItem(context, 'Available', Colors.blueAccent.shade400),
      _legendItem(context, 'Selected', Colors.green),
      _legendItem(context, 'Booked', Colors.redAccent),
    ];

    // Add restricted legend for female users
    if (userGender == 'F') {
      legendItems.add(
        _legendItem(context, 'Restricted (Female)', Colors.grey.shade500),
      );
    }

    return Wrap(spacing: 24, runSpacing: 12, children: legendItems);
  }

  Widget _legendItem(BuildContext context, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

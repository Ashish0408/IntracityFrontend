import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPaymentScreen extends StatefulWidget {
  final String busId;
  final List<String> selectedSeats;
  final Map<String, dynamic> userDetails;

  const QrPaymentScreen({
    super.key,
    required this.busId,
    required this.selectedSeats,
    required this.userDetails,
  });

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen> {
  late String _qrData;
  bool _paymentConfirmed = false;

  @override
  void initState() {
    super.initState();
    _generateQrCode();
  }

  void _generateQrCode() {
    // Generate QR code data containing booking information
    final bookingData = {
      'busId': widget.busId,
      'seats': widget.selectedSeats.join(','),
      'name': widget.userDetails['fullName'],
      'phone': widget.userDetails['phone'],
      'timestamp': DateTime.now().toIso8601String(),
    };

    _qrData = bookingData.toString();
  }

  void _confirmPayment() {
    // Here you would typically verify payment with backend
    setState(() {
      _paymentConfirmed = true;
    });

    // Show confirmation dialog
    _showPaymentConfirmationDialog();
  }

  void _showPaymentConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Confirmed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your booking has been confirmed!'),
            const SizedBox(height: 16),
            _buildConfirmationRow('Name:', widget.userDetails['fullName']),
            _buildConfirmationRow('Phone:', widget.userDetails['phone']),
            _buildConfirmationRow('Seats:', widget.selectedSeats.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'A confirmation SMS/WhatsApp will be sent to your number shortly.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.pop(context);
              // // Navigate back to home or booking list
              // Navigator.pop(context); // Close this screen
              context.beamToNamed('/dashboard');
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booking Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Passenger Name:',
                      widget.userDetails['fullName'],
                    ),
                    _buildSummaryRow(
                      'WhatsApp Number:',
                      '+91 ${widget.userDetails['phone']}',
                    ),
                    _buildSummaryRow('Gender:', widget.userDetails['gender']),
                    _buildSummaryRow(
                      'Age:',
                      '${widget.userDetails['age']} years',
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Selected Seats:',
                      widget.selectedSeats.join(', '),
                    ),
                    _buildSummaryRow(
                      'Number of Seats:',
                      '${widget.selectedSeats.length}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // QR Code Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Scan to Pay',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: 250,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Scan this QR code with your phone camera or any UPI app',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Payment Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade400, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue.shade400, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Payment Instructions',
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Open any UPI app (Google Pay, PhonePe, Paytm, etc.)\n'
                      '2. Tap "Scan QR Code" or use your camera\n'
                      '3. Scan the QR code above\n'
                      '4. Confirm and complete the payment\n'
                      '5. You will receive confirmation on WhatsApp',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Payment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _paymentConfirmed ? null : _confirmPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: _paymentConfirmed
                        ? Colors.grey.shade700
                        : Colors.greenAccent,
                    disabledBackgroundColor: Colors.grey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _paymentConfirmed
                        ? 'Payment Confirmed ✓'
                        : 'Confirm Payment',
                    style: TextStyle(
                      color: _paymentConfirmed ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

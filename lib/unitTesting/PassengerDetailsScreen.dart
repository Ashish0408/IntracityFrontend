import 'package:flutter/material.dart';

class PassengerDetailsScreen extends StatefulWidget {
  final String lockSessionId;
  final String expiresAt;
  final List<String> selectedSeats;

  const PassengerDetailsScreen({
    super.key,
    required this.lockSessionId,
    required this.expiresAt,
    required this.selectedSeats,
  });

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool isProcessing = false;

  Future<void> submitBooking() async {
    setState(() => isProcessing = true);

    await Future.delayed(const Duration(seconds: 1)); // simulate

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Success → Seats BOOKED")),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Locked Seats: ${widget.selectedSeats.join(", ")}"),
            Text("Lock Session ID: ${widget.lockSessionId}"),
            Text("Expires At: ${widget.expiresAt}"),
            const SizedBox(height: 20),

            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Passenger Name"),
            ),
            TextField(
              controller: ageCtrl,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Mobile Number"),
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: isProcessing ? null : submitBooking,
              child: isProcessing
                  ? const CircularProgressIndicator()
                  : const Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
    );
  }
}

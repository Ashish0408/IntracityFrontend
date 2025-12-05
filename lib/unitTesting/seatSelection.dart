import 'package:flutter/material.dart';
import 'DummyAPIFunction.dart';
import '../features/booking/components/layout_map.dart';
import 'PassengerDetailsScreen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final int busId;
  final String layoutId;
  final String date;

  const SeatSelectionScreen({
    super.key,
    required this.busId,
    required this.layoutId,
    required this.date,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<Map<String, dynamic>> bookedSeatList = [];
  Set<String> selectedSeats = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBusData();
  }

  Future<void> loadBusData() async {
    final data = await DummyBusApi.fetchBusDetails(
      busId: widget.busId.toString(),
      date: widget.date,
    );

    print("Fetched Bus Data: $data");

    bookedSeatList = List<Map<String, dynamic>>.from(
      data["bookedSeatConfig"]["seatNumbers"],
    );

    setState(() => isLoading = false);
  }

  Map<String, dynamic>? getBookedSeatInfo(String seatNo) {
    try {
      return bookedSeatList.firstWhere((s) => s["seatNo"] == seatNo);
    } catch (_) {
      return null;
    }
  }

  /// ----------------------------------------------------------
  /// Seat Builder (PASSED to layouts)
  /// ----------------------------------------------------------
  Widget buildSeat(String seatNo, bool isSleeper) {
    final info = getBookedSeatInfo(seatNo);
    final gender = info?["bookForGender"];
    final isBooked = gender != null;

    Color seatColor = Colors.blueAccent;
    if (isBooked) seatColor = gender == "female" ? Colors.pink : Colors.red;
    if (!isBooked && selectedSeats.contains(seatNo)) seatColor = Colors.green;

    return InkWell(
      onTap: () {
        if (isBooked) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$seatNo is booked")));
          return;
        }

        setState(() {
          selectedSeats.contains(seatNo)
              ? selectedSeats.remove(seatNo)
              : selectedSeats.add(seatNo);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 26,
        height: isSleeper ? 52 : 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: seatColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          seatNo,
          style: const TextStyle(fontSize: 9, color: Colors.white),
        ),
      ),
    );
  }

  /// ----------------------------------------------------------
  /// MAIN UI
  /// ----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Select layout dynamically
    final layoutBuilder = seatLayoutMap[widget.layoutId];

    if (layoutBuilder == null) {
      return const Scaffold(body: Center(child: Text("Invalid Layout ID")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Seat Selection")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                child: layoutBuilder(buildSeat: buildSeat),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Selected Seats: ${selectedSeats.join(", ")}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: selectedSeats.isEmpty
                  ? null
                  : () async {
                      final response = await lockSeatsOnServer();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PassengerDetailsScreen(
                            lockSessionId: response["lockSessionId"],
                            expiresAt: response["expiresAt"],
                            selectedSeats: response["lockedSeats"],
                          ),
                        ),
                      );
                    },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> lockSeatsOnServer() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    return {
      "lockSessionId": "LOCK-${DateTime.now().millisecondsSinceEpoch}",
      "expiresAt": DateTime.now()
          .add(const Duration(minutes: 5))
          .toIso8601String(),
      "lockedSeats": selectedSeats.toList(),
    };
  }
}

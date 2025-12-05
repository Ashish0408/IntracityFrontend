import 'package:flutter/material.dart';

class Layout_44_2x1 extends StatefulWidget {
  final Set<String> selectedSeats;
  final Function(Set<String>) onSeatsChanged;
  final List<String> bookedSeats;
  final String userGender; // 'M' for male, 'F' for female, 'O' for other

  const Layout_44_2x1({
    super.key,
    required this.selectedSeats,
    required this.onSeatsChanged,
    required this.bookedSeats,
    required this.userGender,
  });

  @override
  State<Layout_44_2x1> createState() => _Layout_44_2x1State();
}

class _Layout_44_2x1State extends State<Layout_44_2x1> {
  /// Check if a seat is next to a booked seat (adjacent in the same row)
  bool _isNextToBookedSeat(String seatNo) {
    if (!widget.bookedSeats.contains(seatNo)) {
      // Check left and right neighbors based on seat layout
      // For double seats (DU/DL): DU1-DU2, DU3-DU4, etc.
      if (seatNo.startsWith('DU') || seatNo.startsWith('DL')) {
        final num = int.tryParse(seatNo.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        final prefix = seatNo.replaceAll(RegExp(r'[0-9]'), '');

        // Check if next to another double seat
        final leftNeighbor = '$prefix${num - 1}';
        final rightNeighbor = '$prefix${num + 1}';

        if (widget.bookedSeats.contains(leftNeighbor) ||
            widget.bookedSeats.contains(rightNeighbor)) {
          return true;
        }
      }
    }
    return false;
  }

  void toggleSeat(String seatNo) {
    final isBooked = widget.bookedSeats.contains(seatNo);
    final isNextToBooked = _isNextToBookedSeat(seatNo);

    // Female users cannot book seats next to booked seats
    if (widget.userGender == 'F' && isNextToBooked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ Seat $seatNo is next to a booked seat. For safety, female passengers cannot book this seat.',
          ),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    if (isBooked) return;

    if (widget.selectedSeats.contains(seatNo)) {
      widget.selectedSeats.remove(seatNo);
    } else {
      widget.selectedSeats.add(seatNo);
    }
    widget.onSeatsChanged(widget.selectedSeats);
    setState(() {});
  }

  Widget buildSeatBox(String label) {
    final isBooked = widget.bookedSeats.contains(label);
    final isSelected = widget.selectedSeats.contains(label);
    final isNextToBooked = _isNextToBookedSeat(label);
    final isFemaleBlocked =
        widget.userGender == 'F' && isNextToBooked && !isSelected;

    Color color;
    if (isBooked) {
      color = Colors.redAccent;
    } else if (isSelected) {
      color = Colors.green;
    } else if (isFemaleBlocked) {
      // Female users see restricted seats in grey
      color = Colors.grey.shade500;
    } else {
      color = Colors.blueAccent.shade400;
    }

    return GestureDetector(
      onTap: () => toggleSeat(label),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isFemaleBlocked ? Colors.grey : Colors.black26,
            width: isFemaleBlocked ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.all(3),
        width: 42,
        height: 30,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isFemaleBlocked)
                const Positioned(
                  right: 2,
                  top: 2,
                  child: Icon(Icons.lock, size: 8, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftUpper = ["SU1", "SU2", "SU3", "SU4", "SU5", "SU6"];
    final leftLower = ["SL1", "SL2", "SL3", "SL4", "SL5", "SL6"];
    final centerSeats = List.generate(16, (i) => "${i + 1}");
    final rightUpper = List.generate(12, (i) => "DU${i + 1}");
    final rightLower = List.generate(4, (i) => "DL${i + 1}");

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side
              Column(
                children: [
                  ...leftUpper.map((e) => buildSeatBox(e)),
                  const SizedBox(height: 8),
                  ...leftLower.map((e) => buildSeatBox(e)),
                ],
              ),
              const SizedBox(width: 8),
              // Middle
              SizedBox(
                width: 110,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: centerSeats.length,
                  itemBuilder: (context, index) =>
                      buildSeatBox(centerSeats[index]),
                ),
              ),
              const SizedBox(width: 8),
              // Right Upper
              Column(
                children: List.generate(
                  rightUpper.length ~/ 2,
                  (i) => Row(
                    children: [
                      buildSeatBox(rightUpper[i * 2]),
                      buildSeatBox(rightUpper[i * 2 + 1]),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Right Lower
              Column(
                children: List.generate(
                  rightLower.length ~/ 2,
                  (i) => Row(
                    children: [
                      buildSeatBox(rightLower[i * 2]),
                      buildSeatBox(rightLower[i * 2 + 1]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

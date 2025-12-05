import 'package:flutter/material.dart';

class Layout_48_2x1 extends StatefulWidget {
  const Layout_48_2x1({super.key});

  @override
  State<Layout_48_2x1> createState() => _Layout_48_2x1State();
}

class _Layout_48_2x1State extends State<Layout_48_2x1> {
  final Set<String> selectedSeats = {};
  final List<String> bookedSeats = ["DU2", "SL2", "10"]; // example booked

  void toggleSeat(String seatNo) {
    if (bookedSeats.contains(seatNo)) return;
    setState(() {
      if (selectedSeats.contains(seatNo)) {
        selectedSeats.remove(seatNo);
      } else {
        selectedSeats.add(seatNo);
      }
    });
  }

  Widget buildSeatBox(String label) {
    final isBooked = bookedSeats.contains(label);
    final isSelected = selectedSeats.contains(label);

    Color color;
    if (isBooked) {
      color = Colors.redAccent.shade700;
    } else if (isSelected) {
      color = Colors.greenAccent.shade700;
    } else {
      color = Colors.blueAccent.shade400;
    }

    return GestureDetector(
      onTap: () => toggleSeat(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white30, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftSleepers = ["SU1", "SU2", "SU3", "SU4", "SU5", "SU6"];
    final leftSleepersLower = ["SL1", "SL2", "SL3", "SL4", "SL5", "SL6"];
    final centerSeats = List.generate(24, (i) => "${i + 1}");
    final rightSleepers = List.generate(12, (i) => "DU${i + 1}");

    return Center(
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🛏 Left Sleeper (Upper + Lower)
              Column(
                children: [
                  Column(
                    children: leftSleepers
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 40,
                              height: 25,
                              child: buildSeatBox(s),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: leftSleepersLower
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 40,
                              height: 25,
                              child: buildSeatBox(s),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // 🪑 Center Seaters (2 columns)
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: centerSeats.length,
                  itemBuilder: (context, index) {
                    return buildSeatBox(centerSeats[index]);
                  },
                ),
              ),
              const SizedBox(width: 12),

              // 🛏 Right Double Sleepers (2 columns)
              Column(
                children: List.generate(
                  rightSleepers.length ~/ 2,
                  (row) => Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 40,
                          height: 25,
                          child: buildSeatBox(rightSleepers[row * 2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 40,
                          height: 25,
                          child: buildSeatBox(rightSleepers[row * 2 + 1]),
                        ),
                      ),
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

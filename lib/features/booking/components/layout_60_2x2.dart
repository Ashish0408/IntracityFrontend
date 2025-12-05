import 'package:flutter/material.dart';

class Layout_60_2x2 extends StatefulWidget {
  const Layout_60_2x2({super.key});

  @override
  State<Layout_60_2x2> createState() => _Layout_60_2x2State();
}

class _Layout_60_2x2State extends State<Layout_60_2x2> {
  final Set<String> selectedSeats = {};
  final List<String> bookedSeats = ["C5", "D6", "DU3", "CL3"]; // Example booked

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

  Widget buildSeat(String label, String price) {
    final isBooked = bookedSeats.contains(label);
    final isSelected = selectedSeats.contains(label);

    Color color;
    if (isBooked) {
      color = Colors.redAccent;
    } else if (isSelected) {
      color = Colors.green;
    } else {
      color = Colors.grey.shade300;
    }

    return GestureDetector(
      onTap: () => toggleSeat(label),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black26),
        ),
        margin: const EdgeInsets.all(3),
        width: 42,
        height: 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: const TextStyle(fontSize: 9, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftUpper = List.generate(12, (i) => "CU${i + 1}");
    final leftLower = List.generate(6, (i) => "CL${i + 1}");
    final centerLeft = List.generate(12, (i) => "C${i + 1}");
    final centerRight = List.generate(12, (i) => "D${i + 1}");
    final rightUpper = List.generate(12, (i) => "DU${i + 1}");
    final rightLower = List.generate(6, (i) => "DL${i + 1}");

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
              // Left Sleeper Section
              Column(
                children: [
                  ...leftUpper.map((s) => buildSeat(s, "1599")),
                  const SizedBox(height: 8),
                  ...leftLower.map((s) => buildSeat(s, "1899")),
                ],
              ),
              const SizedBox(width: 8),

              // Middle (2 + 2 Seat Layout)
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center Left
                      SizedBox(
                        width: 90,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: centerLeft.length,
                          itemBuilder: (context, index) =>
                              buildSeat(centerLeft[index], "999"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Center Right
                      SizedBox(
                        width: 90,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: centerRight.length,
                          itemBuilder: (context, index) =>
                              buildSeat(centerRight[index], "999"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(width: 8),

              // Right Sleepers
              Column(
                children: [
                  ...List.generate(
                    rightUpper.length ~/ 2,
                    (i) => Row(
                      children: [
                        buildSeat(rightUpper[i * 2], "1599"),
                        buildSeat(rightUpper[i * 2 + 1], "1599"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    rightLower.length ~/ 2,
                    (i) => Row(
                      children: [
                        buildSeat(rightLower[i * 2], "1899"),
                        buildSeat(rightLower[i * 2 + 1], "1899"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

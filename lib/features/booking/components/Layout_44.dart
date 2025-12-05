import 'package:flutter/material.dart';

class Layout44 extends StatelessWidget {
  final Widget Function(String seatNo, bool isSleeper) buildSeat;

  const Layout44({super.key, required this.buildSeat});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------- BUS FRONT --------------
        SizedBox(
          width: 220,
          child: Row(
            children: [
              Container(
                width: 35,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                  ),
                ),
                child: const Icon(Icons.directions_bus, size: 22),
              ),
              Expanded(
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // ---------------- BUS BODY --------------
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- LEFT COLUMN (SU / SL)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i <= 6; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildSeat("SU$i", true),
                          buildSeat("SL$i", true),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 6),

              // ---------------- CENTER COLUMN (ALL S1–S16)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i <= 16; i += 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildSeat("S$i", false),
                          buildSeat("S${i + 1}", false),
                        ],
                      ),
                    ),

                  const SizedBox(height: 6),

                  // DSL seats
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSeat("DSL1", true),
                      buildSeat("DSL2", true),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSeat("DSL3", true),
                      buildSeat("DSL4", true),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 6),

              // ---------------- RIGHT COLUMN (DSU)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i <= 6; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildSeat("DSU${(i * 2)}", true),
                          buildSeat("DSU${(i * 2) - 1}", true),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

typedef SeatBuilder = Widget Function(String seatNo, bool isSleeper);

class Layout48 extends StatelessWidget {
  final SeatBuilder buildSeat;

  const Layout48({super.key, required this.buildSeat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// LEFT SECTION: SU + SL (6 rows × 2 seats)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildSeat("SU${i + 1}", true),
                    buildSeat("SL${i + 1}", true),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(width: 12),

          /// CENTER SECTION: S1-S24 (12 rows × 2 seats in 2 columns)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First column: S2, S4, S6, S8, S10, S12, S14, S16, S18, S20, S22, S24
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(12, (i) {
                  final seatNum = (i + 1) * 2;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildSeat("S$seatNum", false),
                        const SizedBox(width: 6),
                        buildSeat("S${seatNum - 1}", false),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(width: 12),

          /// RIGHT SECTION: DU1-DU12 (6 rows × 2 seats)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildSeat("DU${(i + 1) * 2}", true),
                    buildSeat("DU${(i + 1) * 2 - 1}", true),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'layout_busal.dart';

class BusLayoutScreen extends StatelessWidget {
  final LayoutType layoutType;
  final String busName;

  const BusLayoutScreen({
    super.key,
    required this.layoutType,
    required this.busName,
  });

  @override
  Widget build(BuildContext context) {
    final layoutSeats = seatLayouts[layoutType] ?? [];

    // Calculate max rows & columns from data
    final int maxRow = layoutSeats
        .map((s) => s.row)
        .fold(0, (a, b) => a > b ? a : b);
    final int maxCol = layoutSeats
        .map((s) => s.col)
        .fold(0, (a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: Text('$busName Layout (${layoutType.name.toUpperCase()})'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🚌 Bus box with 100:30 ratio
              AspectRatio(
                aspectRatio: 100 / 30,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      children: [
                        // 🧱 Driver area
                        Container(
                          height: 4.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Driver',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(8),

                        // 🪑 Seat Grid
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate dynamic seat size based on available space
                              final seatWidth =
                                  constraints.maxWidth / (maxCol + 1) - 4;
                              final seatHeight =
                                  constraints.maxHeight / (maxRow + 1) - 4;

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: maxCol + 1,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      childAspectRatio: seatWidth / seatHeight,
                                    ),
                                itemCount: (maxRow + 1) * (maxCol + 1),
                                itemBuilder: (context, index) {
                                  final row = index ~/ (maxCol + 1);
                                  final col = index % (maxCol + 1);

                                  final seat = layoutSeats.firstWhere(
                                    (s) => s.row == row && s.col == col,
                                    orElse: () => SeatModel(
                                      id: '',
                                      price: 0,
                                      isAvailable: false,
                                      type: '',
                                      row: row,
                                      col: col,
                                    ),
                                  );

                                  if (seat.id.isEmpty) {
                                    return const SizedBox();
                                  }

                                  Color color;
                                  switch (seat.type) {
                                    case 'S':
                                      color = Colors.blue.shade400;
                                      break;
                                    case 'SU':
                                    case 'SL':
                                      color = Colors.green.shade400;
                                      break;
                                    case 'DSU':
                                    case 'DSL':
                                      color = Colors.orange.shade400;
                                      break;
                                    default:
                                      color = Colors.grey.shade400;
                                  }

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      seat.id,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        const Gap(8),

                        // 🚪 Exit Area
                        Container(
                          height: 3.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Exit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Gap(12),

              // 🧾 Seat Legend
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _legendItem(Colors.blue.shade400, "Seat (S)"),
                  _legendItem(Colors.green.shade400, "Single Sleeper (SU/SL)"),
                  _legendItem(
                    Colors.orange.shade400,
                    "Double Sleeper (DSU/DSL)",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const Gap(6),
        Text(label, style: TextStyle(fontSize: 9.sp)),
      ],
    );
  }
}

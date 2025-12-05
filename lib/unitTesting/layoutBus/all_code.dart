import 'package:flutter/material.dart';

/// ----------------------
/// ENUMS AND MODELS
/// ----------------------
enum LayoutType { layout48, layout44, layout60 }

class SeatModel {
  final String id;
  final String type; // S / SU / SL / DSL / DSU
  final int row;
  final int col;
  final double price;
  final bool isAvailable;

  SeatModel({
    required this.id,
    required this.type,
    required this.row,
    required this.col,
    required this.price,
    required this.isAvailable,
  });
}

class LayoutModel {
  final LayoutType type;
  final String name;
  final int capacity;
  final List<SeatModel> seats;

  LayoutModel({
    required this.type,
    required this.name,
    required this.capacity,
    required this.seats,
  });
}

class BusModel {
  final String name;
  final LayoutModel layout;

  BusModel({required this.name, required this.layout});
}

/// ----------------------
/// DUMMY DATABASE FUNCTIONS
/// ----------------------
Future<List<LayoutModel>> fetchLayoutsFromDB() async {
  // Simulate async fetch delay
  await Future.delayed(const Duration(milliseconds: 500));

  // Dummy layout data (like seat_templates table)
  final layout48Seats = List.generate(48, (index) {
    final row = index ~/ 3;
    final col = index % 3;
    final type = (col == 2)
        ? 'SU'
        : (row % 2 == 0 ? 'S' : 'DSL'); // just random distribution
    final price = type == 'S'
        ? 999
        : type == 'DSL'
        ? 1399
        : 1599;
    return SeatModel(
      id: 'Seat${index + 1}',
      type: type,
      row: row,
      col: col,
      price: price.toDouble(),
      isAvailable: true,
    );
  });

  final layout44Seats = List.generate(44, (index) {
    final row = index ~/ 4;
    final col = index % 4;
    final type = (col == 3) ? 'DSL' : 'S';
    final price = type == 'S' ? 999 : 1399;
    return SeatModel(
      id: 'Seat${index + 1}',
      type: type,
      row: row,
      col: col,
      price: price.toDouble(),
      isAvailable: true,
    );
  });

  final layout60Seats = List.generate(60, (index) {
    final row = index ~/ 4;
    final col = index % 4;
    final type = (col == 0 || col == 3) ? 'S' : 'SU';
    final price = type == 'S' ? 999 : 1599;
    return SeatModel(
      id: 'Seat${index + 1}',
      type: type,
      row: row,
      col: col,
      price: price.toDouble(),
      isAvailable: true,
    );
  });

  return [
    LayoutModel(
      type: LayoutType.layout48,
      name: "48 Capacity (2+1) Seat/Sleeper",
      capacity: 48,
      seats: layout48Seats,
    ),
    LayoutModel(
      type: LayoutType.layout44,
      name: "44 Capacity (2+1)",
      capacity: 44,
      seats: layout44Seats,
    ),
    LayoutModel(
      type: LayoutType.layout60,
      name: "60 Capacity (2+2)",
      capacity: 60,
      seats: layout60Seats,
    ),
  ];
}

Future<BusModel> createBusWithLayout({
  required String busName,
  required LayoutType selectedLayout,
}) async {
  final layouts = await fetchLayoutsFromDB();
  final layout = layouts.firstWhere(
    (element) => element.type == selectedLayout,
  );
  return BusModel(name: busName, layout: layout);
}

/// ----------------------
/// MAIN SCREEN (Select Bus Layout)
/// ----------------------
class BusLayoutSelectionScreen extends StatefulWidget {
  const BusLayoutSelectionScreen({super.key});

  @override
  State<BusLayoutSelectionScreen> createState() =>
      _BusLayoutSelectionScreenState();
}

class _BusLayoutSelectionScreenState extends State<BusLayoutSelectionScreen> {
  LayoutType? selectedLayout;
  final TextEditingController busNameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bus")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: busNameController,
              decoration: const InputDecoration(
                labelText: "Bus Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: fetchLayoutsFromDB(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final layouts = snapshot.data!;
                return DropdownButtonFormField<LayoutType>(
                  decoration: const InputDecoration(
                    labelText: "Select Layout",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedLayout,
                  items: layouts
                      .map(
                        (l) => DropdownMenuItem(
                          value: l.type,
                          child: Text(l.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => selectedLayout = v),
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (selectedLayout == null ||
                          busNameController.text.isEmpty)
                        return;
                      setState(() => isLoading = true);

                      final bus = await createBusWithLayout(
                        busName: busNameController.text,
                        selectedLayout: selectedLayout!,
                      );

                      setState(() => isLoading = false);

                      // ✅ Navigate to Bus Layout Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BusLayoutScreen(bus: bus),
                        ),
                      );
                    },
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Create Bus"),
            ),
          ],
        ),
      ),
    );
  }
}

/// ----------------------
/// LAYOUT DISPLAY SCREEN
/// ----------------------
class BusLayoutScreen extends StatelessWidget {
  final BusModel bus;
  const BusLayoutScreen({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final seats = bus.layout.seats;

    final maxRow = seats.map((s) => s.row).reduce((a, b) => a > b ? a : b);
    final maxCol = seats.map((s) => s.col).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text(bus.name)),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: maxCol + 1,
              childAspectRatio: 2.5,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: seats.length,
            itemBuilder: (context, index) {
              final seat = seats[index];
              return Container(
                decoration: BoxDecoration(
                  color: seat.type == 'S'
                      ? Colors.green
                      : seat.type == 'DSL'
                      ? Colors.orange
                      : seat.type == 'SU'
                      ? Colors.blue
                      : Colors.purple,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "${seat.id}\n₹${seat.price.toInt()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'bus_layout_screen.dart';
import 'layout_busal.dart';

class AddBusScreen extends HookWidget {
  const AddBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLayout = useState<LayoutType?>(null);
    final seatPriceController = useTextEditingController();
    final doubleSleeperPriceController = useTextEditingController();
    final singleSleeperPriceController = useTextEditingController();
    final totalSeatsController = useTextEditingController();
    final busNameController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add New Bus")),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: ListView(
          children: [
            TextField(decoration: const InputDecoration(labelText: "Bus Name")),
            Gap(2.h),

            DropdownButtonFormField<LayoutType>(
              decoration: const InputDecoration(labelText: "Select Layout"),
              items: layoutNames.entries.map((e) {
                return DropdownMenuItem(value: e.key, child: Text(e.value));
              }).toList(),
              onChanged: (value) => selectedLayout.value = value,
            ),
            Gap(2.h),

            TextField(
              controller: totalSeatsController,
              decoration: const InputDecoration(labelText: "Total Seats"),
              keyboardType: TextInputType.number,
            ),
            Gap(2.h),

            Text(
              "Seat Type Pricing",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            Gap(1.h),

            _priceField("Seat (S)", seatPriceController),
            _priceField(
              "Double Sleeper (DSL/DSU)",
              doubleSleeperPriceController,
            ),
            _priceField("Single Sleeper (SL/SU)", singleSleeperPriceController),

            Gap(3.h),

            ElevatedButton(
              onPressed: () {
                if (selectedLayout.value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a layout')),
                  );
                  return;
                }

                final bus = BusModel(
                  busName: busNameController.text.trim().isEmpty
                      ? "Unnamed Bus"
                      : busNameController.text.trim(),
                  layoutType: selectedLayout.value!,
                  totalSeats: int.tryParse(totalSeatsController.text) ?? 0,
                  pricing: SeatPricing(
                    seatPrice: double.tryParse(seatPriceController.text) ?? 0,
                    doubleSleeperPrice:
                        double.tryParse(doubleSleeperPriceController.text) ?? 0,
                    singleSleeperPrice:
                        double.tryParse(singleSleeperPriceController.text) ?? 0,
                  ),
                );

                // ✅ Navigate to Bus Layout Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BusLayoutScreen(
                      layoutType: bus.layoutType,
                      busName: bus.busName,
                    ),
                  ),
                );
              },
              child: const Text("Save & View Layout"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

double getPriceForSeat(SeatModel seat, SeatPricing pricing) {
  if (seat.id.startsWith('SU') || seat.id.startsWith('SL')) {
    return pricing.singleSleeperPrice;
  } else if (seat.id.startsWith('DSU') || seat.id.startsWith('DSL')) {
    return pricing.doubleSleeperPrice;
  } else {
    return pricing.seatPrice;
  }
}

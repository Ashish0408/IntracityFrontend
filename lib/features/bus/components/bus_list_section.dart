import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../../../core_lib/core.dart';

import '../provider/bus_provider.dart';

class BusListSection extends ConsumerWidget {
  const BusListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the async data provider
    final dataState = ref.watch(
      dataProvider,
    ); // Make sure to watch the correct provider

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Bus", style: Theme.of(context).textTheme.titleMedium),
              // Add category count here
              dataState.maybeWhen(
                data: (data) {
                  final categoryCount = data.filteredBus.length;
                  return Padding(
                    padding: const EdgeInsets.only(right: defaultPadding),
                    child: Text(
                      "Total: $categoryCount",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  );
                },
                orElse: () => SizedBox.shrink(),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: dataState.when(
              // Handle different states using Riverpod's dataState
              data: (data) {
                final buss = data.filteredBus; // or use allBus if needed

                return DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(label: Text("Bus Name")),
                    DataColumn(label: Text("Added Date")),
                    DataColumn(label: Text("Edit")),
                    DataColumn(label: Text("Delete")),
                  ],
                  rows: List.generate(
                    buss.length,
                    (index) => busDataRow(
                      buss[index],
                      delete: () async {
                        await ref
                            .read(busProvider.notifier)
                            .deleteBus(buss[index]); // Use ref.read to delete
                        if (context.mounted) {
                          // Handle any post-delete UI changes (if needed)
                        }
                      },
                      edit: () {
                        print("\n\n EDIT button pressed");
                        if (context.mounted) {
                          final busId = buss[index].busId;
                          context.beamToNamed('/bus/form/$busId');
                        }
                      },
                    ),
                  ),
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(),
              ), // Handle loading state
              error: (error, stack) =>
                  Center(child: Text('Error: $error')), // Handle error state
            ),
          ),
        ],
      ),
    );
  }
}

DataRow busDataRow(BusModel bus, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            // Image.network(
            //   bus.image ?? '',
            //   height: 30,
            //   width: 30,
            //   errorBuilder:
            //       (
            //         BuildContext context,
            //         Object exception,
            //         StackTrace? stackTrace,
            //       ) {
            //         return Icon(Icons.error);
            //       },
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(bus.busName ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(bus.busArrivalTime ?? '')),
      DataCell(
        IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(Icons.edit, color: Colors.white),
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ),
    ],
  );
}

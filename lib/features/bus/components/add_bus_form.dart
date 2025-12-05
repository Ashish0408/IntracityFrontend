import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart'; // ✅ Added

import '../../../core_lib/common/models/bus/stoppage_model.dart';
import '../../../core_lib/common/models/bus/seat_configuration_model.dart';
import '../../../core_lib/core.dart';
import '../../../core_lib/core/utility/date_time_utils.dart';
import '../../booking/components/layout_config.dart' as layout_config;
import '../provider/bus_provider.dart';
import '../provider/cities_provider.dart';
import '../models/seat_type_enum.dart';

class BusSubmitForm extends HookConsumerWidget {
  final BusModel? bus;
  final VoidCallback? onFormSubmitted; // Called after successful submission
  final VoidCallback? onFormCancelled; // Called when user cancels

  const BusSubmitForm({
    super.key,
    this.bus,
    this.onFormSubmitted,
    this.onFormCancelled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addBusFormKey = useMemoized(() => GlobalKey<FormState>());

    // --- Controllers ---
    final busNameCtrl = useTextEditingController(text: bus?.busName ?? '');
    final busDepartureCtrl = useTextEditingController(
      text: bus?.busDepartureTime ?? '',
    );
    final busArrivalCtrl = useTextEditingController(
      text: bus?.busArrivalTime ?? '',
    );

    // --- Cities from provider ---
    final citiesAsync = ref.watch(citiesProvider);

    // --- Selected cities ---
    final fromCity = useState<String?>(bus?.busFromCity);
    final toCity = useState<String?>(bus?.busToCity);

    // --- Stoppages List ---
    final stoppages = useState<List<StoppageModel>>(bus?.busStoppages ?? []);

    // --- Seat Types Configuration (Dynamic) ---
    final seatConfigs = useState<List<SeatTypeConfig>>([]);

    // --- Selected Bus Layout ---
    final selectedLayout = useState<layout_config.BusLayout?>(null);

    void addNewStoppage() {
      stoppages.value = [
        ...stoppages.value,
        const StoppageModel(
          cityName: '',
          arrivalTime: '',
          departureTime: '',
          cumulativePrice: 0,
        ),
      ];
    }

    void removeStoppage(int index) {
      final updated = [...stoppages.value];
      updated.removeAt(index);
      stoppages.value = updated;
    }

    final busNotifier = ref.read(busProvider.notifier);
    useEffect(() {
      if (bus != null) {
        Future.microtask(() => busNotifier.setDataForUpdateBus(bus));
      }
      return null;
    }, []);

    // --- Time Picker ---

    /// Example usage:
    /// - [controller] → holds the human-readable "1:54 PM"
    /// - [onDateTimePicked] → gives the full DateTime string "2025-11-08 13:54:00"

    /// Returns both displayTime (for text field) and fullDateTime (for API)
    /// Returns both displayTime (for UI) and fullTime (for API)
    Future<String?> pickDisplayTime(BuildContext context) async {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (picked == null) return null;

      final localizations = MaterialLocalizations.of(context);
      final displayTime = localizations
          .formatTimeOfDay(picked, alwaysUse24HourFormat: false)
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      debugPrint('[Logger] Picked display time: $displayTime');
      return displayTime; // e.g. "1:45 PM"
    }

    // final busState = ref.watch(busProvider);

    return SingleChildScrollView(
      child: Form(
        key: addBusFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: 90.w, // ✅ Responsive width
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(2.h),

              // // --- Image Picker ---
              // Center(
              //   child: ImageCard(
              //     labelText: "Bus Image",
              //     imageFile: busState.selectedImage,
              //     imageUrlForUpdateImage: bus?.busOperator,
              //     onTap: () => busNotifier.pickImage(),
              //   ),
              // ),
              // Gap(2.h),

              // --- Bus Name + Operator ---
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: busNameCtrl,
                      labelText: 'Bus Name',
                      onSave: (_) {},
                      validator: (v) => v == null || v.isEmpty
                          ? 'Please enter bus name'
                          : null,
                    ),
                  ),
                  // Gap(2.w),
                  // Expanded(
                  //   child: CustomTextField(
                  //     controller: busOperatorCtrl,
                  //     labelText: 'Bus Operator',
                  //     onSave: (_) {},
                  //     validator: (v) => v == null || v.isEmpty
                  //         ? 'Please enter operator'
                  //         : null,
                  //   ),
                  // ),
                ],
              ),
              Gap(2.h),

              // --- From & To City Row ---
              citiesAsync.when(
                data: (cities) => Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<String>(
                        initialValue: fromCity.value,
                        items: cities,
                        hintText: 'From City',
                        displayItem: (c) => c,
                        validator: (val) =>
                            val == null ? 'Select from city' : null,
                        onChanged: (val) {
                          fromCity.value = val;
                          if (toCity.value == val) toCity.value = null;
                        },
                      ),
                    ),
                    Gap(2.w),
                    Expanded(
                      child: CustomDropdown<String>(
                        initialValue: toCity.value,
                        items: cities
                            .where((c) => c != fromCity.value)
                            .toList(),
                        hintText: 'To City',
                        displayItem: (c) => c,
                        validator: (val) =>
                            val == null ? 'Select destination city' : null,
                        onChanged: (val) => toCity.value = val,
                      ),
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Error loading cities: $err'),
              ),
              Gap(2.h),

              // --- Departure & Arrival Row ---
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: busDepartureCtrl,
                      labelText: 'Departure Time',
                      onSave: (_) {},
                      readOnly: true,
                      onTap: () async {
                        final display = await pickDisplayTime(context);
                        if (display != null) {
                          busDepartureCtrl.text = display;
                        }
                      },

                      validator: (v) => v == null || v.isEmpty
                          ? 'Please select departure time'
                          : null,
                    ),
                  ),
                  Gap(2.w),
                  Expanded(
                    child: CustomTextField(
                      controller: busArrivalCtrl,
                      labelText: 'Arrival Time',
                      onSave: (_) {},
                      readOnly: true,
                      onTap: () async {
                        final display = await pickDisplayTime(context);
                        if (display != null) {
                          busArrivalCtrl.text = display;
                        }
                      },

                      validator: (v) => v == null || v.isEmpty
                          ? 'Please select arrival time'
                          : null,
                    ),
                  ),
                ],
              ),
              Gap(2.h),

              // --- Bus Layout Selection ---
              Card(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                child: Padding(
                  padding: EdgeInsets.all(1.2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Bus Layout',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gap(1.h),
                      DropdownButtonFormField<layout_config.BusLayout>(
                        value: selectedLayout.value,
                        decoration: InputDecoration(
                          labelText: 'Choose Layout',
                          border: OutlineInputBorder(),
                          hintText: 'Select a bus layout',
                        ),
                        items: layout_config.busLayouts.values.map((layout) {
                          return DropdownMenuItem<layout_config.BusLayout>(
                            value: layout,
                            child: Text(
                              '${layout.name} - ${layout.capacity} seats',
                            ),
                          );
                        }).toList(),
                        onChanged: (layout_config.BusLayout? newLayout) {
                          if (newLayout != null) {
                            selectedLayout.value = newLayout;
                            // Clear seat configs when layout changes
                            seatConfigs.value = [];
                          }
                        },
                        validator: (layout_config.BusLayout? value) {
                          return value == null
                              ? 'Please select a layout'
                              : null;
                        },
                      ),
                      if (selectedLayout.value != null) ...[
                        Gap(1.h),
                        Container(
                          padding: EdgeInsets.all(1.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Layout Capacity:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${selectedLayout.value!.capacity} seats',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Gap(2.h),

              // --- Seat Types Configuration (Dynamic) --- (Only show if layout selected)
              if (selectedLayout.value == null)
                Card(
                  color: Colors.orange.withOpacity(0.1),
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  child: Padding(
                    padding: EdgeInsets.all(1.2.h),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.orange),
                        Gap(1.w),
                        Expanded(
                          child: Text(
                            'Please select a layout first before adding seat configurations',
                            style: TextStyle(color: Colors.orange.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seat Types Configuration',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Center(
                      child: Builder(
                        builder: (context) {
                          // Calculate current total seats
                          final currentTotal = seatConfigs.value.fold<int>(
                            0,
                            (sum, config) => sum + config.quantity,
                          );
                          final layoutCapacity =
                              selectedLayout.value?.capacity ?? 0;
                          final canAddMore = currentTotal < layoutCapacity;

                          return ElevatedButton.icon(
                            onPressed: canAddMore
                                ? () {
                                    seatConfigs.value = [
                                      ...seatConfigs.value,
                                      SeatTypeConfig(
                                        type: SeatType.s,
                                        quantity: 0,
                                        price: 0.0,
                                      ),
                                    ];
                                  }
                                : null,
                            icon: const Icon(Icons.add_circle),
                            label: const Text('Add Seat Type'),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              // Add Seat Type Button
              if (selectedLayout.value != null) ...[
                Gap(1.5.h),

                // Seat Types List
                if (seatConfigs.value.isEmpty)
                  Center(
                    child: Text(
                      'No seat types added yet. Click "Add Seat Type" to add.',
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  )
                else
                  Column(
                    children: [
                      ...seatConfigs.value.asMap().entries.map((entry) {
                        final index = entry.key;
                        final config = entry.value;

                        final selectedSeatType = useState<SeatType>(
                          config.type,
                        );
                        final quantityCtrl = useTextEditingController(
                          text: config.quantity.toString(),
                        );
                        final priceCtrl = useTextEditingController(
                          text: config.price.toStringAsFixed(2),
                        );

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 0.8.h),
                          child: Padding(
                            padding: EdgeInsets.all(1.2.h),
                            child: Column(
                              children: [
                                // Row 1: Dropdown + Quantity + Price
                                Row(
                                  children: [
                                    // Seat Type Dropdown
                                    Expanded(
                                      flex: 2,
                                      child: DropdownButtonFormField<SeatType>(
                                        value: selectedSeatType.value,
                                        items: SeatType.allTypes.map((type) {
                                          return DropdownMenuItem<SeatType>(
                                            value: type,
                                            child: Text(type.displayName),
                                          );
                                        }).toList(),
                                        onChanged: (SeatType? newType) {
                                          if (newType != null) {
                                            selectedSeatType.value = newType;
                                            seatConfigs.value = [
                                              for (
                                                int i = 0;
                                                i < seatConfigs.value.length;
                                                i++
                                              )
                                                if (i == index)
                                                  seatConfigs.value[i].copyWith(
                                                    type: newType,
                                                  )
                                                else
                                                  seatConfigs.value[i],
                                            ];
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Seat Type',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    Gap(1.5.w),

                                    // Quantity Input
                                    Expanded(
                                      child: TextFormField(
                                        controller: quantityCtrl,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Quantity',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        onChanged: (val) {
                                          final qty = int.tryParse(val) ?? 0;
                                          seatConfigs.value = [
                                            for (
                                              int i = 0;
                                              i < seatConfigs.value.length;
                                              i++
                                            )
                                              if (i == index)
                                                seatConfigs.value[i].copyWith(
                                                  quantity: qty,
                                                )
                                              else
                                                seatConfigs.value[i],
                                          ];
                                        },
                                      ),
                                    ),
                                    Gap(1.5.w),

                                    // Price Input
                                    Expanded(
                                      child: TextFormField(
                                        controller: priceCtrl,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Price',
                                          prefixText: '₹',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        onChanged: (val) {
                                          final price =
                                              double.tryParse(val) ?? 0.0;
                                          seatConfigs.value = [
                                            for (
                                              int i = 0;
                                              i < seatConfigs.value.length;
                                              i++
                                            )
                                              if (i == index)
                                                seatConfigs.value[i].copyWith(
                                                  price: price,
                                                )
                                              else
                                                seatConfigs.value[i],
                                          ];
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        seatConfigs.value = [
                                          for (
                                            int i = 0;
                                            i < seatConfigs.value.length;
                                            i++
                                          )
                                            if (i != index)
                                              seatConfigs.value[i],
                                        ];
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        seatConfigs.value = [
                                          for (
                                            int i = 0;
                                            i < seatConfigs.value.length;
                                            i++
                                          )
                                            if (i == index)
                                              seatConfigs.value[i].copyWith(
                                                isConfirmed: true,
                                              )
                                            else
                                              seatConfigs.value[i],
                                        ];
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: config.isConfirmed
                                            ? Colors.green
                                            : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      Gap(1.h),
                    ],
                  ),

                // Total Seats Display
                if (seatConfigs.value.isNotEmpty)
                  Card(
                    color: primaryColor.withOpacity(0.1),
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Seats',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${seatConfigs.value.fold<int>(0, (sum, config) => sum + config.quantity)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ], // End of if (selectedLayout.value != null)

              Gap(3.h),

              // --- Stoppages Section ---
              // --- Stoppages Section (VERTICAL) ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stoppages',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: addNewStoppage,
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                      ),
                    ],
                  ),
                  Gap(1.h),

                  if (stoppages.value.isEmpty)
                    const Text(
                      'No stoppages added yet. Tap + to add.',
                      style: TextStyle(color: Colors.grey),
                    ),

                  if (stoppages.value.isNotEmpty)
                    citiesAsync.when(
                      data: (cities) {
                        return Column(
                          children: [
                            ...stoppages.value.asMap().entries.map((entry) {
                              final index = entry.key;
                              final stop = entry.value;

                              final city = useState<String?>(stop.cityName);
                              final arrivalCtrl = useTextEditingController(
                                text: stop.arrivalTime ?? '',
                              );
                              final departureCtrl = useTextEditingController(
                                text: stop.departureTime ?? '',
                              );

                              // compute available cities (exclude from/to & other stoppages)
                              final usedCities = stoppages.value
                                  .where(
                                    (s) =>
                                        s.cityName != null &&
                                        s.cityName!.isNotEmpty,
                                  )
                                  .map((s) => s.cityName)
                                  .toSet();

                              final availableCities = cities
                                  .where(
                                    (c) =>
                                        c != fromCity.value &&
                                        c != toCity.value &&
                                        !usedCities.contains(c),
                                  )
                                  .toList();

                              // make sure current value remains selectable when editing
                              if (city.value != null &&
                                  !availableCities.contains(city.value)) {
                                availableCities.add(city.value!);
                              }

                              final isDisabled = availableCities.isEmpty;
                              final initialValue =
                                  availableCities.contains(city.value)
                                  ? city.value
                                  : null;

                              return Card(
                                elevation: 2,
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomDropdown<String>(
                                              initialValue: initialValue,
                                              items: availableCities,
                                              hintText: isDisabled
                                                  ? 'No cities available'
                                                  : 'Select Stoppage City',
                                              displayItem: (c) => c,
                                              validator: (val) => isDisabled
                                                  ? null
                                                  : (val == null
                                                        ? 'Select city'
                                                        : null),
                                              onChanged: (val) {
                                                city.value = val;
                                                stoppages.value = [
                                                  for (
                                                    int i = 0;
                                                    i < stoppages.value.length;
                                                    i++
                                                  )
                                                    if (i == index)
                                                      stoppages.value[i]
                                                          .copyWith(
                                                            cityName: val,
                                                          )
                                                    else
                                                      stoppages.value[i],
                                                ];
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                removeStoppage(index),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(1.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller: arrivalCtrl,
                                              labelText: 'Arrival Time',
                                              readOnly: true,
                                              onTap: () async {
                                                final displayTime =
                                                    await pickDisplayTime(
                                                      context,
                                                    );
                                                if (displayTime != null) {
                                                  arrivalCtrl.text =
                                                      displayTime;
                                                  stoppages
                                                      .value[index] = stoppages
                                                      .value[index]
                                                      .copyWith(
                                                        arrivalTime:
                                                            TimeUtils.toApiTime(
                                                              displayTime,
                                                            ), // 🔄 convert for backend
                                                      );
                                                }
                                              },
                                              onSave: (_) {},
                                              validator: (v) =>
                                                  v == null || v.isEmpty
                                                  ? 'Enter time'
                                                  : null,
                                            ),
                                          ),
                                          Gap(2.w),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: departureCtrl,
                                              labelText: 'Departure Time',
                                              readOnly: true,
                                              onTap: () async {
                                                final displayTime =
                                                    await pickDisplayTime(
                                                      context,
                                                    );
                                                if (displayTime != null) {
                                                  departureCtrl.text =
                                                      displayTime;
                                                  stoppages
                                                      .value[index] = stoppages
                                                      .value[index]
                                                      .copyWith(
                                                        departureTime:
                                                            TimeUtils.toApiTime(
                                                              displayTime,
                                                            ),
                                                      );
                                                }
                                              },
                                              onSave: (_) {},
                                              validator: (v) =>
                                                  v == null || v.isEmpty
                                                  ? 'Enter time'
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(1.h),
                                      // CustomTextField(
                                      //   controller: priceCtrl,
                                      //   labelText: 'Cumulative Price (₹)',
                                      //   inputType: TextInputType.number,
                                      //   onChanged: (v) {
                                      //     stoppages.value[index] = stoppages
                                      //         .value[index]
                                      //         .copyWith(
                                      //           cumulativePrice:
                                      //               double.tryParse(v),
                                      //         );
                                      //   },
                                      //   onSave: (_) {},
                                      //   validator: (v) => v == null || v.isEmpty
                                      //       ? 'Enter price'
                                      //       : null,
                                      // ),
                                      Gap(0.8.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onPressed: () =>
                                                removeStoppage(index),
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: stop.isConfirmed
                                                  ? Colors.green
                                                  : Colors.blue,
                                              minimumSize: const Size(80, 36),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            icon: Icon(
                                              stop.isConfirmed
                                                  ? Icons.check_circle
                                                  : Icons.check,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            label: Text(
                                              stop.isConfirmed ? 'Added' : 'OK',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              stoppages.value = [
                                                for (
                                                  int i = 0;
                                                  i < stoppages.value.length;
                                                  i++
                                                )
                                                  if (i == index)
                                                    stoppages.value[i].copyWith(
                                                      isConfirmed: true,
                                                    )
                                                  else
                                                    stoppages.value[i],
                                              ];
                                              // auto add a new empty stoppage if this is the last one
                                              // if (index ==
                                              //     stoppages.value.length - 1) {
                                              //   addNewStoppage();
                                              // }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),

                            // Optional small spacer then an explicit Add button always visible below the list
                            Gap(1.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: OutlinedButton.icon(
                                onPressed: addNewStoppage,
                                icon: const Icon(Icons.add),
                                label: const Text('Add Stop'),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) =>
                          Text('Error loading stoppage cities: $err'),
                    ),
                ],
              ),

              Gap(3.h),

              // --- Submit / Cancel ---
              SubmitCancelButtons(
                formKey: addBusFormKey,
                onCancel: () {
                  busNotifier.clearFields();
                  onFormCancelled?.call();
                },
                onSubmit: () async {
                  if (!addBusFormKey.currentState!.validate()) return;

                  // Validate layout is selected
                  if (selectedLayout.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a bus layout'),
                      ),
                    );
                    return;
                  }

                  // Validate that at least one seat type is selected
                  final totalSeats = seatConfigs.value.fold<int>(
                    0,
                    (sum, config) => sum + config.quantity,
                  );
                  if (totalSeats == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add at least one seat type'),
                      ),
                    );
                    return;
                  }

                  // Validate that total seats matches the layout capacity
                  if (totalSeats != selectedLayout.value!.capacity) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Total seats (${totalSeats}) must equal the layout capacity (${selectedLayout.value!.capacity})',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Validate stoppages
                  if (stoppages.value.isNotEmpty) {
                    // Check if all stoppages are confirmed
                    final unconfirmedStoppages = stoppages.value
                        .where((s) => !s.isConfirmed)
                        .toList();
                    if (unconfirmedStoppages.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please confirm all stoppages before submitting',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Validate each stoppage has required fields
                    for (int i = 0; i < stoppages.value.length; i++) {
                      final stoppage = stoppages.value[i];

                      // Check city name
                      if (stoppage.cityName == null ||
                          stoppage.cityName!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Stoppage ${i + 1}: Please select a city',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Check arrival time
                      if (stoppage.arrivalTime == null ||
                          stoppage.arrivalTime!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Stoppage ${i + 1}: Please enter arrival time',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Check departure time
                      if (stoppage.departureTime == null ||
                          stoppage.departureTime!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Stoppage ${i + 1}: Please enter departure time',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                    }
                  }

                  // Build stoppages list from controllers
                  final stoppageList = stoppages.value.map((s) {
                    return StoppageModel(
                      cityName: s.cityName,
                      arrivalTime: s.arrivalTime,
                      departureTime: s.departureTime,
                      cumulativePrice: s.cumulativePrice,
                    );
                  }).toList();
                  Logger.info('Stoppage List: $stoppageList');

                  // Convert seat configs to SeatConfigurationModel list
                  final seatConfigList = seatConfigs.value
                      .map(
                        (config) => SeatConfigurationModel(
                          seatType: config.type.code,
                          noOfSeats: config.quantity,
                          pricePerSeat: config.price,
                        ),
                      )
                      .toList();

                  Logger.info('Seat Config List: $seatConfigList');

                  final newBus = BusModel(
                    busId: bus?.busId,
                    busName: busNameCtrl.text,
                    busOperator: 'Vande fly pvt ltd',
                    busFromCity: fromCity.value,
                    busToCity: toCity.value,
                    busDepartureTime: TimeUtils.toApiTime(
                      busDepartureCtrl.text,
                    ),
                    busArrivalTime: TimeUtils.toApiTime(busArrivalCtrl.text),
                    busTotalSeats: totalSeats,
                    busAvailableSeats: totalSeats,
                    busPrice: seatConfigList
                        .map((e) => e.pricePerSeat * e.noOfSeats)
                        .reduce((value, element) => value + element),
                    busStoppages: stoppageList,
                    busLayoutId: selectedLayout.value?.id,
                    busSeatConfigurations: seatConfigList,
                  );

                  ref.read(busProvider.notifier).setDataForUpdateBus(newBus);
                  await busNotifier.submitBus();

                  // Call the callback to notify parent (e.g., to navigate back)
                  onFormSubmitted?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Removed the dialog-based showAddBusForm function
// Now using Beamer navigation instead

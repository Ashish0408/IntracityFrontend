import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:intl/intl.dart';
import '../../../core_lib/core.dart';
import '../bus/provider/cities_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String _sourceCityValue = '';
  String _destCityValue = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<BusModel> _searchResults = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _performSearch() {
    final provider = ref.read(dataProvider.notifier);
    final travelDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    Logger.info('🔍 Search initiated:');
    Logger.info('  From: $_sourceCityValue');
    Logger.info('  To: $_destCityValue');
    Logger.info('  Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}');
    Logger.info('  Time: ${_selectedTime.format(context)}');

    setState(() {
      _searchResults = provider.searchBuses(
        sourceCity: _sourceCityValue,
        destinationCity: _destCityValue,
        travelDateTime: travelDateTime,
      );
      Logger.info('  Results found: ${_searchResults.length} buses');
      _hasSearched = true;
    });
  }

  void _clearSearch() {
    Logger.info('🧹 Search cleared');
    setState(() {
      _hasSearched = false;
      _searchResults = [];
      _sourceCityValue = '';
      _destCityValue = '';
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(dataProvider)
        .when(
          data: (_) => _buildContent(context),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
  }

  Widget _buildContent(BuildContext context) {
    final nextBus = ref.read(dataProvider.notifier).getNextAvailableBus();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== SEARCH SECTION =====
            ref
                .watch(citiesProvider)
                .when(
                  data: (cities) => _buildSearchCard(context, cities),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      const Center(child: Text('Error loading cities')),
                ),
            const SizedBox(height: 24),
            // ===== RESULTS SECTION =====
            if (_hasSearched)
              _buildSearchResults(context)
            else
              _buildNextBusSection(context, nextBus),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context, List<String> cities) {
    return Card(
      elevation: 2,
      color: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Buses',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_hasSearched)
                  TextButton(
                    onPressed: _clearSearch,
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // Row with From, To, and Date
            Row(
              children: [
                // Source City Field (1/3 width)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue value) {
                          return cities
                              .where(
                                (city) => city.toLowerCase().contains(
                                  value.text.toLowerCase(),
                                ),
                              )
                              .toList();
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _sourceCityValue = selection;
                          });
                        },
                        fieldViewBuilder:
                            (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              // Keep the autocomplete controller in sync with our state
                              if (_sourceCityValue.isNotEmpty &&
                                  textEditingController.text !=
                                      _sourceCityValue) {
                                textEditingController.text = _sourceCityValue;
                              }
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'From',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                  filled: true,
                                  fillColor: bgColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                              );
                            },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Destination City Field (1/3 width)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue value) {
                          return cities
                              .where(
                                (city) => city.toLowerCase().contains(
                                  value.text.toLowerCase(),
                                ),
                              )
                              .toList();
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _destCityValue = selection;
                          });
                        },
                        fieldViewBuilder:
                            (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              // Keep the autocomplete controller in sync with our state
                              if (_destCityValue.isNotEmpty &&
                                  textEditingController.text !=
                                      _destCityValue) {
                                textEditingController.text = _destCityValue;
                              }
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'To',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                  filled: true,
                                  fillColor: bgColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                              );
                            },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Date Field (1/3 width)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: primaryColor,
                                    surface: secondaryColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() => _selectedDate = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd MMM').format(_selectedDate),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: primaryColor,
                                    surface: secondaryColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() => _selectedTime = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedTime.format(context),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.access_time,
                                color: primaryColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Search Button
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _performSearch,
                          icon: const Icon(Icons.search),
                          label: const Text('Search'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextBusSection(BuildContext context, BusModel? nextBus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Next Available Bus',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        nextBus == null ? _emptyCard(context) : _busCard(context, nextBus),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results (${_searchResults.length} buses)',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (_searchResults.isEmpty)
          _noBusCard(context)
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return _busCard(context, _searchResults[index]);
            },
          ),
      ],
    );
  }

  Widget _busCard(BuildContext context, BusModel nextBus) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // ✅ Navigate via Beamer
        context.beamToNamed('/booking/${nextBus.busId}/L001');
      },
      child: Card(
        elevation: 3,
        color: secondaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.directions_bus, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        "Next Available Bus",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoTile("Name", nextBus.busName ?? "-"),
                  _infoTile("From", nextBus.busFromCity ?? "-"),
                  _infoTile("To", nextBus.busToCity ?? "-"),
                ],
              ),
              const Divider(color: Colors.white24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoTile("Departure", nextBus.busDepartureTime ?? "-"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );

  Widget _emptyCard(BuildContext context) => Card(
    color: secondaryColor.withOpacity(0.7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          'No upcoming buses available.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    ),
  );

  Widget _noBusCard(BuildContext context) => Card(
    color: secondaryColor.withOpacity(0.7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          'No bus available for this route.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    ),
  );
}

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core_lib/core.dart';
import '../../../features/bus/provider/cities_provider.dart';

/// Home Screen - Exact Vande Fly design match
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _sourceCityValue = '';
  String _destCityValue = '';
  DateTime _selectedDate = DateTime.now();
  DateTime? _returnDate;
  bool _isRoundTrip = false;

  void _performSearch() {
    if (_sourceCityValue.isEmpty || _destCityValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both cities')),
      );
      return;
    }
    context.beamToNamed(
      '/users/buses?from=$_sourceCityValue&to=$_destCityValue&date=${_selectedDate.toIso8601String()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner Section
            _buildHeroBanner(),
            // Regular Destinations Section
            _buildRegularDestinationsSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFF9800),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'Vande\nFly',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      title: const Text(
        'VANDEFLYTRAVELS@GMAIL.COM',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFF9800),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              '7290904029',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      color: const Color(0xFFFFF3E0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Card
          _buildSearchCard(),
          const SizedBox(height: 20),
          // Promotional Banner
          _buildPromoBanner(),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Trip Type Toggle
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isRoundTrip = false),
                  child: Column(
                    children: [
                      Text(
                        'ONE WAY',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: _isRoundTrip
                              ? Colors.grey
                              : const Color(0xFF7B2CBF),
                        ),
                      ),
                      if (!_isRoundTrip)
                        Container(
                          height: 2,
                          width: 60,
                          color: const Color(0xFF7B2CBF),
                          margin: const EdgeInsets.only(top: 6),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isRoundTrip = true),
                  child: Column(
                    children: [
                      Text(
                        'ROUND TRIP',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: _isRoundTrip
                              ? const Color(0xFF7B2CBF)
                              : Colors.grey,
                        ),
                      ),
                      if (_isRoundTrip)
                        Container(
                          height: 2,
                          width: 60,
                          color: const Color(0xFF7B2CBF),
                          margin: const EdgeInsets.only(top: 6),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Search Fields Row
          ref
              .watch(citiesProvider)
              .when(
                data: (cities) => Row(
                  children: [
                    // Origin
                    Expanded(
                      child: _buildSearchField(
                        label: 'Origin',
                        icon: Icons.location_on,
                        value: _sourceCityValue,
                        items: cities,
                        onChanged: (value) =>
                            setState(() => _sourceCityValue = value ?? ''),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Swap Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          final temp = _sourceCityValue;
                          _sourceCityValue = _destCityValue;
                          _destCityValue = temp;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF7B2CBF),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.swap_horiz,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Destination
                    Expanded(
                      child: _buildSearchField(
                        label: 'Destination',
                        icon: Icons.location_on,
                        value: _destCityValue,
                        items: cities,
                        onChanged: (value) =>
                            setState(() => _destCityValue = value ?? ''),
                      ),
                    ),
                  ],
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
          const SizedBox(height: 16),
          // Date and Return Date Row
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  label: 'Departure',
                  date: _selectedDate,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() => _selectedDate = pickedDate);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              if (_isRoundTrip)
                Expanded(
                  child: _buildDateField(
                    label: 'Return',
                    date: _returnDate ?? DateTime.now(),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            _returnDate ??
                            _selectedDate.add(const Duration(days: 1)),
                        firstDate: _selectedDate.add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() => _returnDate = pickedDate);
                      }
                    },
                  ),
                ),
              const SizedBox(width: 12),
              // Search Button
              SizedBox(
                height: 50,
                width: 130,
                child: ElevatedButton(
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B2CBF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'SEARCH',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            items: items
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(icon, size: 18, color: Colors.grey),
              hintText: 'Select',
              border: InputBorder.none,
              hintStyle: const TextStyle(fontSize: 12),
            ),
            iconSize: 20,
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(date),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'UPTO',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFF9800),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '40%',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'On your first bus booking',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFFF9800), width: 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'BOOK NOW',
                    style: TextStyle(
                      color: Color(0xFFFF9800),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right side - Download App Badge
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: const Column(
              children: [
                Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'The App Now',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularDestinationsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Text(
            'Regular Destinations',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFFFF9800),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'OUR POPULAR ROUTES',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 32),
          // Popular Routes Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildRouteCard('Delhi'),
              _buildRouteCard('Kanpur'),
              _buildRouteCard('Lucknow'),
              _buildRouteCard('Patna'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(String cityName) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Icon(Icons.image, size: 60, color: Colors.grey.shade500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              cityName.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

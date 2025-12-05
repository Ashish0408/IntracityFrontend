import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';
import '../../../core_lib/core.dart';
import '../../../unitTesting/DummyAPIFunction.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../widgets/app_footer_widget.dart';

/// Bus List Screen - Shows search results for bus bookings with filters
class BusListScreen extends ConsumerStatefulWidget {
  final String fromCity;
  final String toCity;
  final String travelDate;

  const BusListScreen({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.travelDate,
  });

  @override
  ConsumerState<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends ConsumerState<BusListScreen> {
  late Future<List<Map<String, dynamic>>> _searchResultsFuture;
  String? _selectedDepartureRange;
  String? _selectedBusType;
  String? _selectedSort = 'departure';
  late ScrollController _dateScrollController;
  int _dateOffset = 0;
  late DateTime _selectedDate;
  late DateTime _baseDate;
  List<Map<String, dynamic>> _filteredBuses = [];

  @override
  void initState() {
    super.initState();
    try {
      _baseDate = DateTime.parse(widget.travelDate);
    } catch (_) {
      _baseDate = DateTime.now();
    }
    _selectedDate = _baseDate;
    _dateScrollController = ScrollController();
    _searchResultsFuture = DummyBusApi.searchBuses(
      from: widget.fromCity,
      to: widget.toCity,
      date: _selectedDate.toIso8601String(),
    );
  }

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  void _updateSearchResults() {
    setState(() {
      _searchResultsFuture = DummyBusApi.searchBuses(
        from: widget.fromCity,
        to: widget.toCity,
        date: _selectedDate.toIso8601String(),
      );
    });
  }

  /// Apply filters to buses
  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> buses) {
    var filtered = buses;

    // Filter by departure time
    if (_selectedDepartureRange != null) {
      filtered = filtered.where((bus) {
        final deptTime = bus['busDepartureTime'] ?? '';
        final hour = int.tryParse(deptTime.split(':')[0]) ?? 0;

        switch (_selectedDepartureRange) {
          case 'morning':
            return hour >= 5 && hour < 12;
          case 'afternoon':
            return hour >= 12 && hour < 17;
          case 'evening':
            return hour >= 17 && hour < 21;
          case 'night':
            return hour >= 21 || hour < 5;
          default:
            return true;
        }
      }).toList();
    }

    // Filter by bus type
    if (_selectedBusType != null) {
      filtered = filtered.where((bus) {
        final busType = (bus['busType'] ?? '').toLowerCase();
        return busType.contains(_selectedBusType!.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Navigation Menu
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 60,
            pinned: true,
            title: AppNavigationMenuWidget(
              currentPage: '/users/buses',
              onLogoTap: () {
                context.beamToNamed('/users/home');
              },
            ),
          ),
          // Search Bar Section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route and Date Info
                  Text(
                    '${widget.fromCity} - ${widget.toCity} on ${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF17283a),
                    ),
                  ),
                  Gap(1.h),
                  // Quick Filter Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          '${widget.toCity} - ${widget.fromCity} on ${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
                          const Color(0xFF17283a),
                          const Color(0xFFf05a28),
                        ),
                        // Gap(1.w),
                        // _buildFilterChip(
                        //   'Skip Return',
                        //   Colors.black87,
                        //   Colors.transparent,
                        //   borderColor: Colors.grey,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Date Selector Section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Left Arrow
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_dateOffset > 0) {
                              _dateOffset -= 7;
                            }
                          });
                        },
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.chevron_left,
                              size: 20.sp,
                              color: const Color(0xFF17283a),
                            ),
                          ),
                        ),
                      ),
                      Gap(1.w),
                      // Date List
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _dateScrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(14, (index) {
                              final date = _baseDate.add(
                                Duration(days: _dateOffset + index),
                              );
                              final dayName = DateFormat('EEE').format(date);
                              final dayNum = DateFormat('dd').format(date);
                              final monthStr = DateFormat('MMM').format(date);
                              final isSelected =
                                  date.year == _selectedDate.year &&
                                  date.month == _selectedDate.month &&
                                  date.day == _selectedDate.day;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDate = date;
                                  });
                                  _updateSearchResults();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 1.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFf05a28)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFf05a28)
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayName,
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        dayNum,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        monthStr,
                                        style: TextStyle(
                                          fontSize: 7.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Gap(1.w),
                      // Right Arrow
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dateOffset += 7;
                          });
                        },
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.chevron_right,
                              size: 20.sp,
                              color: const Color(0xFF17283a),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Filter and Sort Row
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter:',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Gap(1.w),
                          _buildSortButton('Depart', _selectedDepartureRange),
                          Gap(1.w),
                          _buildSortButton('Bus Type', _selectedBusType),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(height: 1, color: Colors.grey.shade300),
          ),
          // Bus List
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _searchResultsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: CircularProgressIndicator(
                          color: const Color(0xFFf05a28),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_bus_filled,
                              size: 48.sp,
                              color: Colors.grey.shade300,
                            ),
                            Gap(2.h),
                            Text(
                              'No buses available',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final buses = snapshot.data!;
                  final filteredBuses = _applyFilters(buses);

                  if (filteredBuses.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 48.sp,
                              color: Colors.grey.shade300,
                            ),
                            Gap(2.h),
                            Text(
                              'No buses match your filters',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            Gap(1.h),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDepartureRange = null;
                                  _selectedBusType = null;
                                });
                              },
                              child: Text(
                                'Clear Filters',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFFf05a28),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(filteredBuses.length, (index) {
                      final bus = filteredBuses[index];
                      return _buildBusCard(bus);
                    }),
                  );
                },
              ),
            ),
          ),
          // Footer
          SliverToBoxAdapter(child: const AppFooterWidget()),
        ],
      ),
    );
  }

  /// Build filter chip
  Widget _buildFilterChip(
    String label,
    Color textColor,
    Color backgroundColor, {
    Color? borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor ?? backgroundColor, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  /// Build sort button with dropdown
  Widget _buildSortButton(String label, String? selectedValue) {
    List<String> options = [];
    if (label == 'Depart') {
      options = [
        'Morning (5AM-12PM)',
        'Afternoon (12PM-5PM)',
        'Evening (5PM-9PM)',
        'Night (9PM-5AM)',
      ];
    } else if (label == 'Bus Type') {
      options = ['Sleeper', 'Seater', 'AC', 'Non-AC'];
    }

    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          if (label == 'Depart') {
            _selectedDepartureRange = value == selectedValue ? null : value;
          } else if (label == 'Bus Type') {
            _selectedBusType = value == selectedValue ? null : value;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          color: selectedValue != null
              ? const Color(0xFFf05a28).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: selectedValue != null
                ? const Color(0xFFf05a28)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedValue != null ? '$label: $selectedValue' : label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: selectedValue != null
                    ? const Color(0xFFf05a28)
                    : Colors.black87,
              ),
            ),
            Gap(0.5.w),
            Icon(
              Icons.expand_more,
              size: 14.sp,
              color: selectedValue != null
                  ? const Color(0xFFf05a28)
                  : Colors.grey,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => options
          .map(
            (option) => PopupMenuItem(
              value: option.split(' ')[0].toLowerCase(),
              child: Text(option),
            ),
          )
          .toList(),
    );
  }

  /// Build bus card
  Widget _buildBusCard(Map<String, dynamic> bus) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Service Name, Type, and Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus['busName'] ?? 'Unknown Bus',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF17283a),
                      ),
                    ),
                    Gap(0.5.h),
                    Text(
                      bus['busType'] ?? '2+2, Sleeper/Seater',
                      style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                    ),
                    if (bus['via'] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 0.5.h),
                        child: Icon(
                          Icons.info_outline,
                          size: 12.sp,
                          color: const Color(0xFFf05a28),
                        ),
                      ),
                  ],
                ),
              ),
              // Divider
              Container(
                width: 1,
                height: 6.h,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
              ),
              // Departure and Arrival Times
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bus['busDepartureTime'] ?? '22:30',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      bus['busFromCity'] ?? 'From',
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                    Gap(0.8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        Gap(0.5.w),
                        Text(
                          bus['duration'] ?? '09 Hrs',
                          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    Gap(0.8.h),
                    Text(
                      bus['busArrivalTime'] ?? '07:30',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      bus['busToCity'] ?? 'To',
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 6.h,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
              ),
              // Price and Button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rs. ${bus['busPrice']?.toStringAsFixed(0) ?? '299'}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFf05a28),
                      ),
                    ),
                    Text(
                      '${bus['busAvailableSeats'] ?? 25} Seats available',
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                    Gap(1.5.h),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.beamToNamed(
                            '/users/seats/${bus['busId']}?busName=${bus['busName']}&departureTime=${bus['busDepartureTime']}&arrivalTime=${bus['busArrivalTime']}&fromCity=${bus['busFromCity']}&toCity=${bus['busToCity']}&date=${bus['date']}&price=${bus['busPrice']}',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFf05a28),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'VIEW SEATS',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Additional Info
          Divider(color: Colors.grey.shade200, height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Boarding Points',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: const Color(0xFF17283a),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Dropping Points',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: const Color(0xFF17283a),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(0.8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  (bus['boardingPoints'] as List?)?.join(', ') ??
                      'Delhi City Center',
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: const Color(0xFF17283a),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  (bus['droppingPoints'] as List?)?.join(', ') ??
                      'Lucknow City',
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: const Color(0xFF17283a),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

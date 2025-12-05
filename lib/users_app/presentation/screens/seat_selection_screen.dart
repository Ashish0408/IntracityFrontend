import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';
import '../../../unitTesting/DummyAPIFunction.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../../../features/booking/components/layout_map.dart';
import '../widgets/app_footer_widget.dart';

/// Seat Selection Screen - Choose seats from bus layout
class SeatSelectionScreen extends StatefulWidget {
  final String busId;
  final String busName;
  final String departureTime;
  final String arrivalTime;
  final String fromCity;
  final String toCity;
  final String date;
  final double price;

  const SeatSelectionScreen({
    super.key,
    required this.busId,
    required this.busName,
    required this.departureTime,
    required this.arrivalTime,
    required this.fromCity,
    required this.toCity,
    required this.date,
    required this.price,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<Map<String, dynamic>> _busDetailsFuture;
  Set<String> selectedSeats = {};
  String? selectedBoardingPoint;
  String? selectedDroppingPoint;

  @override
  void initState() {
    super.initState();
    _busDetailsFuture = DummyBusApi.fetchBusDetails(
      busId: widget.busId,
      date: widget.date,
    );
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
              currentPage: '/users/seat-selection',
              onLogoTap: () {
                context.beamToNamed('/users/home');
              },
            ),
          ),
          // Bus Info Section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100.w < 600 ? double.infinity : 85.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.busName,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF17283a),
                                  ),
                                ),
                                Gap(0.5.h),
                                Text(
                                  '${widget.departureTime} → ${widget.arrivalTime}',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                Gap(0.5.h),
                                Text(
                                  '${widget.fromCity} → ${widget.toCity}',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 4.w,
                              height: 4.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(2.h),
                      Divider(color: Colors.grey.shade300),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100.w < 600 ? double.infinity : 85.w,
                  ),
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _busDetailsFuture,
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

                      if (!snapshot.hasData) {
                        return Center(child: Text('Error loading bus details'));
                      }

                      final busDetails = snapshot.data!;
                      final seatLayout =
                          busDetails['seatConfig']['seatLayout'] as List;
                      final bookedSeats =
                          (busDetails['bookedSeatConfig']['seatNumbers']
                                  as List)
                              .map((s) => s['seatNo'] as String)
                              .toSet();

                      return !isMobile
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildSeatLayout(
                                    seatLayout,
                                    bookedSeats,
                                  ),
                                ),
                                Gap(3.w),
                                Expanded(
                                  flex: 1,
                                  child: _buildFareDetails(seatLayout),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildSeatLayout(seatLayout, bookedSeats),
                                Gap(3.h),
                                _buildFareDetails(seatLayout),
                              ],
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
          // Footer
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF2a2a2a),
              child: AppFooterWidget(),
            ),
          ),
        ],
      ),
    );
  }

  /// Build seat layout grid using Layout48/Layout44 components
  Widget _buildSeatLayout(List<dynamic> seatLayout, Set<String> bookedSeats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seat Legend
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seat Status',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(0.7.h),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 4,
                mainAxisSpacing: 0.5.h,
                crossAxisSpacing: 0.5.w,
                children: [
                  _buildLegendItem('Available', Colors.grey.shade400),
                  _buildLegendItem('Selected', const Color(0xFF4CAF50)),
                  _buildLegendItem('Booked', Colors.black),
                  _buildLegendItem('Ladies(L)', Colors.pink.shade300),
                ],
              ),
            ],
          ),
        ),
        Gap(1.5.h),
        // Seat Grid - Using Layout48/Layout44 components
        Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 60.h),
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: _buildSeatLayoutWithComponent(seatLayout, bookedSeats),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build seat layout using Layout48 or Layout44 component
  Widget _buildSeatLayoutWithComponent(
    List<dynamic> seatLayout,
    Set<String> bookedSeats,
  ) {
    // Default to L001 (Layout48) if layoutId not provided
    final layoutId = 'L001';
    final layoutBuilder = seatLayoutMap[layoutId];

    if (layoutBuilder == null) {
      return Text('Layout $layoutId not found');
    }

    return layoutBuilder(
      buildSeat: (seatId, isSleeper) =>
          _buildSeatWidget(seatId, isSleeper, bookedSeats),
    );
  }

  /// Build individual seat widget
  Widget _buildSeatWidget(
    String seatId,
    bool isSleeper,
    Set<String> bookedSeats,
  ) {
    final isBooked = bookedSeats.contains(seatId);
    final isSelected = selectedSeats.contains(seatId);
    final isLadies = seatId.startsWith('L');

    return Padding(
      padding: EdgeInsets.all(0.3.w),
      child: GestureDetector(
        onTap: isBooked
            ? null
            : () {
                setState(() {
                  if (selectedSeats.contains(seatId)) {
                    selectedSeats.remove(seatId);
                  } else {
                    selectedSeats.add(seatId);
                  }
                });
              },
        child: Container(
          width: 4.2.w,
          height: 4.2.w,
          decoration: BoxDecoration(
            color: isBooked
                ? Colors.black
                : isLadies
                ? Colors.pink.shade300
                : isSelected
                ? const Color(0xFF4CAF50)
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
            border: isSelected
                ? Border.all(color: const Color(0xFFf05a28), width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              seatId,
              style: TextStyle(
                fontSize: 6.5.sp,
                fontWeight: FontWeight.bold,
                color: (isBooked || isSelected || isLadies)
                    ? Colors.white
                    : Colors.black87,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  /// Build legend item
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 1.5.w,
          height: 1.5.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Gap(0.4.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 7.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  /// Build fare details section
  Widget _buildFareDetails(List<dynamic> seatLayout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seat Price Filter
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seat Price',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(1.h),
              Wrap(
                spacing: 1.w,
                runSpacing: 1.h,
                children: [
                  _buildPriceButton('All', true),
                  _buildPriceButton('899', false),
                  _buildPriceButton('1111', false),
                  _buildPriceButton('1250', false),
                ],
              ),
            ],
          ),
        ),
        Gap(2.h),
        // Fare Details
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fare Details',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFf05a28),
                ),
              ),
              Gap(1.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seats',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                  Text(
                    '${selectedSeats.length}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Gap(1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ticket Fare',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                  Text(
                    '₹ 0',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Gap(2.h),
              Divider(color: Colors.grey.shade300),
              Gap(1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '₹ 0',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Gap(2.h),
        // Boarding and Dropping Points
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Boarding Point',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(1.h),
              DropdownButtonFormField(
                value: selectedBoardingPoint,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 1.2.h,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Delhi City Center',
                    child: Text('Delhi City Center'),
                  ),
                  DropdownMenuItem(
                    value: 'Delhi Airport',
                    child: Text('Delhi Airport'),
                  ),
                ].map((item) => item).toList(),
                onChanged: (value) {
                  setState(() => selectedBoardingPoint = value);
                },
                hint: Text('Select Boarding Point'),
              ),
              Gap(2.h),
              Text(
                'Dropping Point',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(1.h),
              DropdownButtonFormField(
                value: selectedDroppingPoint,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 1.2.h,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Lucknow Station',
                    child: Text('Lucknow Station'),
                  ),
                  DropdownMenuItem(
                    value: 'Lucknow City',
                    child: Text('Lucknow City'),
                  ),
                ].map((item) => item).toList(),
                onChanged: (value) {
                  setState(() => selectedDroppingPoint = value);
                },
                hint: Text('Select Dropping Point'),
              ),
              Gap(2.h),
              SizedBox(
                width: double.infinity,
                height: 5.h,
                child: ElevatedButton(
                  onPressed: selectedSeats.isEmpty
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Proceeding with ${selectedSeats.length} seat(s)',
                              ),
                              backgroundColor: const Color(0xFFf05a28),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf05a28),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 12.sp,
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
    );
  }

  /// Build price button
  Widget _buildPriceButton(String price, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFf05a28) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? const Color(0xFFf05a28) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        price,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../widgets/app_footer_widget.dart';

/// Manage Booking Page - for Print, Update, Cancel and Pre/Postpone Ticket
class ManageBookingScreen extends StatefulWidget {
  const ManageBookingScreen({super.key});

  @override
  State<ManageBookingScreen> createState() => _ManageBookingScreenState();
}

class _ManageBookingScreenState extends State<ManageBookingScreen> {
  final _ticketNumberController = TextEditingController();
  final _emailPhoneController = TextEditingController();

  @override
  void dispose() {
    _ticketNumberController.dispose();
    _emailPhoneController.dispose();
    super.dispose();
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
              currentPage: '/users/bookings',
              onLogoTap: () {
                context.beamToNamed('/users/home');
              },
            ),
          ),
          // Hero Banner
          SliverToBoxAdapter(
            child: Container(
              height: isMobile ? 20.h : 25.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFf05a28),
                    const Color(0xFFf8931f),
                    const Color(0xFFfaa555),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20.w,
                    bottom: -10.h,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'MANAGE BOOKING',
                      style: TextStyle(
                        fontSize: isMobile ? 12.sp : 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
              child: !isMobile
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildSearchForm(isMobile)),
                        Gap(4.w),
                        Expanded(
                          flex: 1,
                          child: _buildMTicketSection(isMobile),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildSearchForm(isMobile),
                        Gap(4.h),
                        _buildMTicketSection(isMobile),
                      ],
                    ),
            ),
          ),
          // Footer
          SliverToBoxAdapter(child: const AppFooterWidget()),
        ],
      ),
    );
  }

  /// Build search form section
  Widget _buildSearchForm(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info Alert
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFf05a28), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, color: const Color(0xFFf05a28), size: 16.sp),
              Gap(1.w),
              Expanded(
                child: Text(
                  'Please enter the details for Print, Update, Cancel and Pre/Postpone Ticket.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(3.h),
        // Ticket Number Field
        Text(
          'Ticket Number',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Gap(1.h),
        TextField(
          controller: _ticketNumberController,
          decoration: InputDecoration(
            hintText: 'Enter ticket number',
            hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFf05a28), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 1.5.h,
            ),
          ),
          style: TextStyle(fontSize: 11.sp),
        ),
        Gap(3.h),
        // Email/Phone Field
        Text(
          'Email/Phone Number',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Gap(1.h),
        TextField(
          controller: _emailPhoneController,
          decoration: InputDecoration(
            hintText: 'Enter email or phone number',
            hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFf05a28), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 1.5.h,
            ),
          ),
          style: TextStyle(fontSize: 11.sp),
        ),
        Gap(3.h),
        // Search Button
        SizedBox(
          width: double.infinity,
          height: 5.h,
          child: ElevatedButton(
            onPressed: () {
              // Handle search
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Searching for ticket: ${_ticketNumberController.text}',
                  ),
                  backgroundColor: const Color(0xFFf05a28),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFf05a28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Gap(3.h),
        // Terms and Conditions
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '*Please read the ',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Terms And Conditions',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xFFf05a28),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: ' about the Cancellation Policy.',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build M-Ticket section
  Widget _buildMTicketSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Go With M-Ticket',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Gap(3.h),
        // M-Ticket Card
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.phone_android,
                      color: Colors.grey.shade600,
                      size: 8.w,
                    ),
                  ),
                  Gap(2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Show M-Ticket with ID Proof',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '(Government Authorized ID)',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'NO ',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFf05a28),
                              ),
                            ),
                            TextSpan(
                              text: 'Need to Print Ticket',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(0.5.h),
                      Text(
                        'Use of Paper',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.eco, color: Color(0xFF66BB6A)),
                  ),
                ],
              ),
              Gap(2.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              Gap(2.h),
              // App Download Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Download Android or iOS App',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'and Get Flat Discount',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Gap(1.5.h),
                  SizedBox(
                    height: 5.h,
                    child: Image.asset(
                      'assets/images/google_play.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

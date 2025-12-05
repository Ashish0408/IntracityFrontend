import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../widgets/app_footer_widget.dart';

/// About Us Page - Vande Fly company information
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
              currentPage: '/users/about',
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
                      'ABOUT US',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Description
                  _buildDescriptionSection(isMobile),
                  Gap(4.h),
                  // Live Bus Tracking Section
                  _buildFeatureSection(
                    isMobile,
                    title: 'Live Bus Tracking',
                    content:
                        'We have integrated this great technology of live bus tracking in almost all of our buses. This helps the passengers to be informed about the live position of the bus, thus helping them in planning their commute to the bus stand. It also prevents the unwanted stress of missing or waiting for the bus in case of delays.',
                  ),
                  Gap(4.h),
                  // Customer Support Section
                  _buildFeatureSection(
                    isMobile,
                    title: 'Our Customer Support',
                    content:
                        'To render the best service we strive to provide the best customer support. We have an attentive customer support team to which the passengers can report any issues regarding the journey. This team addresses all the issues of the passengers and comes out with a solution in the shortest possible time. This creates a warm feeling in the customers thus pushing them to be our regular customers.',
                  ),
                  Gap(4.h),
                  // Great Comfort Section
                  _buildFeatureSection(
                    isMobile,
                    title: 'Great Comfort',
                    content:
                        'Comfort is our priority. All our buses are equipped with comfortable seating, air conditioning, and modern amenities to ensure a pleasant journey. We continuously upgrade our fleet with the latest technology and comfort features.',
                  ),
                  Gap(4.h),
                  // Vision & Mission Section
                  _buildVisionMissionSection(isMobile),
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

  /// Build main description section
  Widget _buildDescriptionSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vande Fly is a renowned brand in the bus operating industry. Our vision is to give a new face to the bus industry. Since our inception passenger comfort was our top priority. We have frequently added luxury buses to our huge fleet of buses. The only thing we focus on is that the comfort quotient of our passengers should never be compromised. We have always tried our best to push our limits in order to develop our travel experience. Read further to understand what we offer that enhances our reputation in the market.',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.black87,
            height: 1.8,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Build feature section
  Widget _buildFeatureSection(
    bool isMobile, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Gap(1.5.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.black87,
            height: 1.8,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Build vision and mission section
  Widget _buildVisionMissionSection(bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFf05a28), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Vision',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFf05a28),
                  ),
                ),
                Gap(1.h),
                Text(
                  'To revolutionize the bus travel industry by providing world-class comfort and reliable service.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(2.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFf8931f), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFf8931f),
                  ),
                ),
                Gap(1.h),
                Text(
                  'To deliver exceptional travel experiences with safety, comfort, and reliability at every journey.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

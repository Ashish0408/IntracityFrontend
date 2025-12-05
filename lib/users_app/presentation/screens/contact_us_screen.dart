import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../widgets/app_footer_widget.dart';
import '../widgets/contact_top_info_bar_widget.dart';

/// Contact Us Page - Vande Fly style contact information
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
              currentPage: '/users/contact',
              onLogoTap: () {
                context.beamToNamed('/users/home');
              },
            ),
          ),

          // // Top Info Bar
          // SliverToBoxAdapter(
          //   child: ContactTopInfoBarWidget(
          //     onAgentLoginTap: () {
          //       // Add agent login navigation here
          //     },
          //   ),
          // ),
          SliverToBoxAdapter(child: Gap(2.h)),
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
                      'CONTACT US',
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
                children: [
                  // Get in Touch Section
                  if (!isMobile)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildGetInTouchSection(isMobile)),
                        Gap(4.w),
                        Expanded(child: _buildEPaymentSection(isMobile)),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildGetInTouchSection(isMobile),
                        Gap(4.h),
                        _buildEPaymentSection(isMobile),
                      ],
                    ),
                  Gap(5.h),
                  // Other Branches Section
                  _buildOtherBranchesSection(isMobile),
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

  /// Build "Get in Touch with us" Section
  Widget _buildGetInTouchSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Get in ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              'Touch with us',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFf05a28),
              ),
            ),
          ],
        ),

        Gap(3.h),
        // Location
        _buildContactItem(
          icon: Icons.location_on,
          title: 'Vande Fly',
          content:
              'Vande Fly Lounge, B-83, Maruti Complex, Singar Nagar., Nahariya Chauraha Alambag. Lucknow, Anmol Restaurant, Near Dev Hospital, Lucknow, Uttar Pradesh -226005',
        ),
        Gap(2.h),
        // Phone
        _buildContactItem(icon: Icons.phone, title: '', content: '7290904029'),
        Gap(1.5.h),
        // Email
        _buildContactItem(
          icon: Icons.email,
          title: '',
          content: 'vandeflytravels@gmail.com',
        ),
      ],
    );
  }

  /// Build "E-Payment related issues" Section
  Widget _buildEPaymentSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'E',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              '-Payment related issues',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),

        Gap(3.h),
        // Phone
        _buildContactItem(
          icon: Icons.phone,
          title: '',
          content: '080-46333629',
        ),
        Gap(2.h),
        // Email
        _buildContactItem(
          icon: Icons.email,
          title: '',
          content: 'support@mybusbookings.com',
        ),
      ],
    );
  }

  /// Build individual contact item
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: const Color(0xFFf05a28),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14.sp, color: Colors.white),
        ),
        Gap(2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              if (title.isNotEmpty) Gap(0.5.h),
              Text(
                content,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build "Other Branches" Section
  Widget _buildOtherBranchesSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Text(
          'Branches',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Gap(3.h),
        // Lucknow Branch Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: const Color(0xFFf05a28),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lucknow',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.remove, color: Colors.white, size: 16.sp),
            ],
          ),
        ),
        Gap(2.h),
        // Branch Details
        _buildBranchCard(
          name: 'Vande Fly',
          address:
              'Vande Fly Lounge, B-83, Maruti Complex, Singar Nagar., Nahariya Chauraha Alambag. Lucknow, Anmol Restaurant, Near Dev Hospital Lucknow, Uttar Pradesh Pin: 226005',
          phone: '7290904029',
          email: 'vandeflytravels@gmail.com',
        ),
      ],
    );
  }

  /// Build branch card
  Widget _buildBranchCard({
    required String name,
    required String address,
    required String phone,
    required String email,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFf05a28),
            ),
          ),
          Gap(1.h),
          Text(
            address,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          Gap(1.5.h),
          Row(
            children: [
              Icon(Icons.phone, size: 12.sp, color: const Color(0xFFf05a28)),
              Gap(0.8.w),
              Text(
                phone,
                style: TextStyle(fontSize: 10.sp, color: Colors.black87),
              ),
              Gap(2.w),
              Icon(Icons.email, size: 12.sp, color: const Color(0xFFf05a28)),
              Gap(0.8.w),
              Expanded(
                child: Text(
                  email,
                  style: TextStyle(fontSize: 10.sp, color: Colors.black87),
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Reusable Footer Widget for all pages
class AppFooterWidget extends StatelessWidget {
  final String? companyName;
  final String? address;
  final String? phone;
  final String? email;
  final String? copyrightYear;

  const AppFooterWidget({
    super.key,
    this.companyName = 'Vande Fly',
    this.address =
        'Vande Fly Lounge, B-83, Maruti Complex, Singar Nagar., Nahariya Chauraha Alambag. Lucknow, Anmol Restaurant, Near Dev Hospital, Lucknow, Uttar Pradesh -226005',
    this.phone = '7290904029',
    this.email = 'vandeflytravels@gmail.com',
    this.copyrightYear = '2024',
  });

  // Quick Links Data
  static const List<Map<String, String>> quickLinks = [
    {'label': 'Gallery', 'route': '/users/gallery'},
    {'label': 'Testimonials', 'route': '/users/testimonials'},
    {'label': 'Terms & Conditions', 'route': '/users/terms'},
    {'label': 'Contact Us', 'route': '/users/contact'},
    {'label': 'About Us', 'route': '/users/about'},
    {'label': 'Schedules', 'route': '/users/schedules'},
    {'label': 'Agent Login', 'route': '/users/agent-login'},
    {'label': 'Contact', 'route': '/users/contact'},
    {'label': 'Privacy Policy', 'route': '/users/privacy'},
    {'label': 'FAQs', 'route': '/users/faqs'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Container(
      color: const Color(0xFF2a2a2a),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 4.w : 6.w,
        vertical: isMobile ? 4.h : 6.h,
      ),
      child: Column(
        children: [
          // Main Footer Content
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Section
                Expanded(child: _buildContactSection(isMobile)),
                Gap(4.w),
                // Quick Links Section
                Expanded(flex: 2, child: _buildQuickLinksSection(isMobile)),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactSection(isMobile),
                Gap(3.h),
                _buildQuickLinksSection(isMobile),
              ],
            ),
          Gap(3.h),
          // Divider
          Container(height: 1, color: Colors.grey.shade700),
          Gap(2.h),
          // Copyright
          Center(
            child: Text(
              '© $copyrightYear All rights reserved. $companyName',
              style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade400),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Build Contact Section
  Widget _buildContactSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Gap(1.5.h),
        // Company Name with Location Icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, size: 16.sp, color: Colors.white),
            Gap(1.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Gap(0.5.h),
                  Text(
                    address!,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.grey.shade300,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(2.h),
        // Phone
        Row(
          children: [
            Icon(Icons.phone, size: 14.sp, color: Colors.white),
            Gap(1.w),
            GestureDetector(
              onTap: () async {
                final Uri phoneUri = Uri(scheme: 'tel', path: phone);
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                }
              },
              child: Text(
                phone!,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey.shade300,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        Gap(1.h),
        // Email
        Row(
          children: [
            Icon(Icons.email, size: 14.sp, color: Colors.white),
            Gap(1.w),
            GestureDetector(
              onTap: () async {
                final Uri emailUri = Uri(scheme: 'mailto', path: email);
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                }
              },
              child: Text(
                email!,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey.shade300,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build Quick Links Section
  Widget _buildQuickLinksSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK LINKS',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Gap(1.5.h),
        // Links Grid
        if (!isMobile)
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 1.h,
            childAspectRatio: 3.5,
            children: List.generate(quickLinks.length, (index) {
              final link = quickLinks[index];
              return _buildLinkItem(link['label']!, link['route']!);
            }),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(quickLinks.length, (index) {
              final link = quickLinks[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: _buildLinkItem(link['label']!, link['route']!),
              );
            }),
          ),
      ],
    );
  }

  /// Build individual link item
  Widget _buildLinkItem(String label, String route) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
        // context.beamToNamed(route);
      },
      child: Row(
        children: [
          Icon(
            Icons.chevron_right,
            size: 14.sp,
            color: const Color(0xFFf05a28),
          ),
          Gap(0.5.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade300),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

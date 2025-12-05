import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// Features Widget - Shows "Why Choose Us" section with feature cards
class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget({super.key});

  static const List<Map<String, String>> features = [
    {
      'icon': '⚡',
      'title': 'Fast Booking',
      'description': 'Quick and easy booking process',
    },
    {
      'icon': '😊',
      'title': 'Stress Free',
      'description': 'Comfortable journey assured',
    },
    {
      'icon': '💰',
      'title': 'Spend Less',
      'description': 'Best prices guaranteed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: isMobile ? 3.h : 4.h,
          ),
          child: Text(
            'Why Choose Us',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF17283a),
            ),
          ),
        ),
        Gap(2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: isMobile
              ? Column(
                  children: features
                      .map(
                        (feature) => Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: _buildFeatureCard(
                            feature['icon']!,
                            feature['title']!,
                            feature['description']!,
                            isMobile,
                          ),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  children: features
                      .map(
                        (feature) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: _buildFeatureCard(
                              feature['icon']!,
                              feature['title']!,
                              feature['description']!,
                              isMobile,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        Gap(3.h),
      ],
    );
  }

  Widget _buildFeatureCard(
    String icon,
    String title,
    String description,
    bool isMobile,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 3.w : 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(icon, style: TextStyle(fontSize: 32.sp)),
          Gap(2.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF17283a),
            ),
            textAlign: TextAlign.center,
          ),
          Gap(1.h),
          Text(
            description,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

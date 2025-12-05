import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// Popular Routes Widget - Shows city destinations grid
class PopularRoutesWidget extends StatelessWidget {
  const PopularRoutesWidget({super.key});

  // Sample cities - can be made dynamic from provider
  static const List<Map<String, String>> popularCities = [
    {'name': 'Delhi', 'emoji': '🏛️'},
    {'name': 'Kanpur', 'emoji': '🏭'},
    {'name': 'Lucknow', 'emoji': '🕌'},
    {'name': 'Patna', 'emoji': '⛩️'},
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Regular Destinations',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFf05a28),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Gap(1.h),
              Center(
                child: Text(
                  'OUR POPULAR ROUTES',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF17283a),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: isMobile ? 2.w : 3.w,
              mainAxisSpacing: isMobile ? 2.h : 3.h,
              childAspectRatio: 1.2,
            ),
            itemCount: popularCities.length,
            itemBuilder: (context, index) {
              final city = popularCities[index];
              return _buildCityCard(city['name']!, city['emoji']!);
            },
          ),
        ),
        Gap(3.h),
      ],
    );
  }

  Widget _buildCityCard(String cityName, String emoji) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle city tap
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: 32.sp)),
              Gap(2.h),
              Text(
                cityName,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF17283a),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

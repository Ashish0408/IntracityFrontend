import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// Amenities Widget - Shows available bus amenities grid
class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({super.key});

  static const List<Map<String, String>> amenities = [
    {'icon': '🔌', 'name': 'Charging'},
    {'icon': '💧', 'name': 'Water'},
    {'icon': '🛏️', 'name': 'Blanket'},
    {'icon': '🛌', 'name': 'Pillow'},
    {'icon': '💡', 'name': 'Lamp'},
    {'icon': '🎵', 'name': 'Entertainment'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            'Amenities',
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
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 3 : 6,
              crossAxisSpacing: isMobile ? 3.w : 2.w,
              mainAxisSpacing: isMobile ? 3.h : 2.h,
              childAspectRatio: 1.0,
            ),
            itemCount: amenities.length,
            itemBuilder: (context, index) {
              final amenity = amenities[index];
              return _buildAmenityCard(amenity['icon']!, amenity['name']!);
            },
          ),
        ),
        Gap(3.h),
      ],
    );
  }

  Widget _buildAmenityCard(String icon, String name) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle amenity tap
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: TextStyle(fontSize: 28.sp)),
              Gap(2.h),
              Text(
                name,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF17283a),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

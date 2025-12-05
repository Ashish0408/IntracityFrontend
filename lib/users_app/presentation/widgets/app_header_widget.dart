import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// App Header Widget - Shows branding and contact information
class AppHeaderWidget extends StatelessWidget {
  final String? email;
  final String? phone;

  const AppHeaderWidget({
    super.key,
    this.email = 'hello@vandefly.com',
    this.phone = '+91 9876543210',
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 3.w : 4.w,
        vertical: isMobile ? 2.h : 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Logo/Branding
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFf05a28),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 2.w : 2.5.w,
              vertical: isMobile ? 1.h : 1.5.h,
            ),
            child: Text(
              'Vande\nFly',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 11.sp : 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
          // Right side - Contact info
          if (!isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (email != null)
                  Text(
                    email!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFFf05a28),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (phone != null) ...[
                  Gap(0.5.h),
                  Text(
                    phone!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// Top Info Bar Widget - Displays email, phone, and agent login button
class ContactTopInfoBarWidget extends StatelessWidget {
  final VoidCallback? onAgentLoginTap;

  const ContactTopInfoBarWidget({super.key, this.onAgentLoginTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.email, size: 16.sp, color: const Color(0xFFf05a28)),
              Gap(1.w),
              Text(
                'VANDEFLYTRAVELS@GMAIL.COM',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF17283a),
                ),
              ),
              Gap(2.w),
              Icon(Icons.phone, size: 16.sp, color: const Color(0xFFf05a28)),
              Gap(1.w),
              Text(
                '7290904029',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF17283a),
                ),
              ),
            ],
          ),
          if (!isMobile)
            GestureDetector(
              onTap: onAgentLoginTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFf05a28), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'AGENT LOGIN',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFf05a28),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

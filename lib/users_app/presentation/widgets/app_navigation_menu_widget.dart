import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:beamer/beamer.dart';

/// Reusable Navigation Menu Widget for all pages
class AppNavigationMenuWidget extends StatelessWidget {
  final String? currentPage;
  final VoidCallback? onLogoTap;

  const AppNavigationMenuWidget({super.key, this.currentPage, this.onLogoTap});

  // Menu items
  static const List<Map<String, String>> menuItems = [
    {'label': 'HOME', 'route': '/users/home'},
    // {'label': 'MANAGE BOOKINGS', 'route': '/users/bookings'},
    // {'label': 'GALLERY', 'route': '/users/gallery'},
    {'label': 'ABOUT US', 'route': '/users/about'},
    {'label': 'Contact US', 'route': '/users/contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 4.w : 6.w,
        vertical: isMobile ? 2.h : 2.5.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Section
          GestureDetector(
            onTap:
                onLogoTap ??
                () {
                  context.beamToNamed('/users/home');
                },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 2.w : 2.5.w,
                vertical: isMobile ? 1.h : 1.5.h,
              ),
              child: Image.asset('assets/images/ValuexLogo.png'),
            ),
          ),

          // Menu Items (Hidden on very small screens)
          if (!isMobile)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(menuItems.length, (index) {
                  final item = menuItems[index];
                  final isActive = currentPage == item['route'];

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                    child: GestureDetector(
                      onTap: () {
                        context.beamToNamed(item['route']!);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['label']!,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? const Color(0xFFf05a28)
                                  : const Color(0xFF17283a),
                            ),
                          ),
                          if (isActive)
                            Padding(
                              padding: EdgeInsets.only(top: 0.5.h),
                              child: Container(
                                height: 2,
                                width: 6.w,
                                color: const Color(0xFFf05a28),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

          // Mobile Menu Button
          if (isMobile)
            IconButton(
              icon: Icon(
                Icons.menu,
                size: 24.sp,
                color: const Color(0xFFf05a28),
              ),
              onPressed: () {
                _showMobileMenu(context);
              },
            ),
        ],
      ),
    );
  }

  /// Show mobile menu as bottom sheet or drawer
  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF17283a),
                ),
              ),
            ),
            Divider(color: const Color(0xFFfec866), thickness: 1),
            ...List.generate(menuItems.length, (index) {
              final item = menuItems[index];
              final isActive = currentPage == item['route'];

              return ListTile(
                leading: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFf05a28)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  item['label']!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFFf05a28)
                        : const Color(0xFF17283a),
                  ),
                ),
                onTap: () {
                  context.beamToNamed(item['route']!);
                  Navigator.pop(context);
                },
              );
            }),
            Gap(2.h),
          ],
        ),
      ),
    );
  }
}

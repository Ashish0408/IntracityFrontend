import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

/// Promotional Banner Widget with Image Carousel
class PromoBannerWidget extends StatefulWidget {
  const PromoBannerWidget({super.key});

  @override
  State<PromoBannerWidget> createState() => _PromoBannerWidgetState();
}

class _PromoBannerWidgetState extends State<PromoBannerWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  // Promotional images/banners
  static const List<String> promoBanners = [
    'assets/images/banner_banner-1.jpg',
    'assets/images/banner_banner-2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Column(
      children: [
        // Carousel
        Container(
          height: isMobile ? 25.h : 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _startAutoScroll();
              },
              itemCount: promoBanners.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  promoBanners[index],
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFfec866),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 48.sp,
                              color: Colors.grey,
                            ),
                            Gap(2.h),
                            Text(
                              'Banner Image',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Gap(2.h),
        // Carousel Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promoBanners.length,
            (index) => GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: _currentPage == index ? 3.w : 2.w,
                height: 0.8.h,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFf05a28)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

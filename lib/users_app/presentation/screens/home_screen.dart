import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../../../core_lib/core.dart';
import '../../../features/bus/provider/cities_provider.dart';
import '../widgets/app_footer_widget.dart';
import '../widgets/app_header_widget.dart';
import '../widgets/app_navigation_menu_widget.dart';
import '../widgets/search_card_widget.dart';
import '../widgets/promo_banner_widget.dart';
import '../widgets/popular_routes_widget.dart';
import '../widgets/features_widget.dart';
import '../widgets/amenities_widget.dart';

/// Home Screen - Vande Fly style bus search interface
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _sourceCityValue = '';
  String _destCityValue = '';
  DateTime _selectedDate = DateTime.now();

  void _performSearch() {
    if (_sourceCityValue.isEmpty || _destCityValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both cities')),
      );
      return;
    }
    context.beamToNamed(
      '/users/buses?from=$_sourceCityValue&to=$_destCityValue&date=${_selectedDate.toIso8601String()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9dba9),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFf9dba9),
              const Color(0xFFf9dba9).withOpacity(0.6),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              pinned: true,
              title: AppNavigationMenuWidget(
                currentPage: '/users/home',
                onLogoTap: () {
                  context.beamToNamed('/users/home');
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Hero Section with Search
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            const Color(0xFFf9dba9).withOpacity(0.8),
                            const Color(0xFFf9dba9),
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                      padding: EdgeInsets.only(top: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Card Widget
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: SearchCardWidget(
                              sourceCityValue: _sourceCityValue,
                              destCityValue: _destCityValue,
                              selectedDate: _selectedDate,
                              onSourceCityChanged: (value) {
                                setState(() => _sourceCityValue = value);
                              },
                              onDestCityChanged: (value) {
                                setState(() => _destCityValue = value);
                              },
                              onDateChanged: (date) {
                                setState(() => _selectedDate = date);
                              },
                              onSearch: _performSearch,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Promo Banner Widget
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: const PromoBannerWidget(),
                    ),
                    Gap(3.h),
                    // Popular Routes Widget
                    const PopularRoutesWidget(),
                    // Features Widget
                    const FeaturesWidget(),
                    // Amenities Widget
                    const AmenitiesWidget(),
                    Gap(4.h),
                    AppFooterWidget(
                      companyName: 'Vande Fly',
                      phone: '7290904029',
                      email: 'vandeflytravels@gmail.com',
                      copyrightYear: '2024',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

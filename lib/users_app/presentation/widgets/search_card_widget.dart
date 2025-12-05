import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../../../features/bus/provider/cities_provider.dart';

/// Search Card Widget - One Way trip with origin/destination, date, and search button
class SearchCardWidget extends ConsumerStatefulWidget {
  final String sourceCityValue;
  final String destCityValue;
  final DateTime selectedDate;
  final Function(String) onSourceCityChanged;
  final Function(String) onDestCityChanged;
  final Function(DateTime) onDateChanged;
  final VoidCallback onSearch;

  const SearchCardWidget({
    super.key,
    required this.sourceCityValue,
    required this.destCityValue,
    required this.selectedDate,
    required this.onSourceCityChanged,
    required this.onDestCityChanged,
    required this.onDateChanged,
    required this.onSearch,
  });

  @override
  ConsumerState<SearchCardWidget> createState() => _SearchCardWidgetState();
}

class _SearchCardWidgetState extends ConsumerState<SearchCardWidget> {
  @override
  Widget build(BuildContext context) {
    final isMobile = 100.w < 600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 4.w : 6.w),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSearchFields(true),
        Gap(3.h),
        _buildDateField(true),
        Gap(3.h),
        _buildSearchButton(true),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 2, child: _buildSearchFields(false)),
        Gap(4.w),
        Expanded(flex: 1, child: _buildDateField(false)),
        Gap(4.w),
        Expanded(
          flex: 1,
          child: SizedBox(height: 8.h, child: _buildSearchButton(false)),
        ),
      ],
    );
  }

  Widget _buildSearchFields(bool isMobile) {
    final citiesAsync = ref.watch(citiesProvider);

    return citiesAsync.when(
      data: (cities) => isMobile
          ? Column(
              children: [
                _buildDropdownField(
                  label: 'From',
                  value: widget.sourceCityValue,
                  items: cities,
                  onChanged: widget.onSourceCityChanged,
                ),
                Gap(2.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        label: 'To',
                        value: widget.destCityValue,
                        items: cities,
                        onChanged: widget.onDestCityChanged,
                      ),
                    ),
                    Gap(2.w),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF17283a),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.swap_horiz,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _swapCities,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildDropdownField(
                    label: 'From',
                    value: widget.sourceCityValue,
                    items: cities,
                    onChanged: widget.onSourceCityChanged,
                  ),
                ),
                Gap(2.w),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF17283a),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.swap_horiz,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _swapCities,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
                Gap(2.w),
                Expanded(
                  child: _buildDropdownField(
                    label: 'To',
                    value: widget.destCityValue,
                    items: cities,
                    onChanged: widget.onDestCityChanged,
                  ),
                ),
              ],
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  void _swapCities() {
    widget.onSourceCityChanged(widget.destCityValue);
    widget.onDestCityChanged(widget.sourceCityValue);
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF17283a),
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(1.h),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: const Color(0xFFfec866), width: 2),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            items: items
                .map(
                  (city) => DropdownMenuItem(
                    value: city,
                    child: Text(city, style: TextStyle(fontSize: 11.sp)),
                  ),
                )
                .toList(),
            onChanged: (val) => onChanged(val ?? ''),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2.h),
              prefixIcon: Icon(
                Icons.location_on,
                size: 18.sp,
                color: const Color(0xFFf05a28),
              ),
              hintText: 'Select city',
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 12.sp),
            ),
            iconSize: 20,
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Departure',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF17283a),
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(1.h),
        InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: widget.selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (pickedDate != null) {
              widget.onDateChanged(pickedDate);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: const Color(0xFFfec866), width: 2),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18.sp,
                  color: const Color(0xFFf05a28),
                ),
                Gap(2.w),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton(bool isMobile) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onSearch,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF17283a),
          padding: EdgeInsets.symmetric(vertical: isMobile ? 3.5.h : 3.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
        child: Text(
          'SEARCH',
          style: TextStyle(
            fontSize: isMobile ? 16.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

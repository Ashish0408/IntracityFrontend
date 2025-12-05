import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core_lib/core.dart';
import 'qr_payment_screen.dart';
import '../../../unitTesting/DummyAPIFunction.dart';

class UserDetailsScreen extends StatefulWidget {
  final String busId;
  final List<String> selectedSeats;
  final String? date;

  const UserDetailsScreen({
    super.key,
    required this.busId,
    required this.selectedSeats,
    this.date,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  Map<String, dynamic>? _busDetails;
  bool _isLoadingBusDetails = true;

  @override
  void initState() {
    super.initState();
    _loadBusDetails();
  }

  Future<void> _loadBusDetails() async {
    try {
      final details = await DummyBusApi.fetchBusDetails(
        busId: widget.busId,
        date: widget.date ?? DateTime.now().toIso8601String().split('T').first,
      );

      if (mounted) {
        setState(() {
          _busDetails = details;
          _isLoadingBusDetails = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading bus details: $e');
      if (mounted) {
        setState(() {
          _isLoadingBusDetails = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_phoneCtrl.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrPaymentScreen(
          busId: widget.busId,
          selectedSeats: widget.selectedSeats,
          userDetails: {
            'fullName': _fullNameCtrl.text,
            'phone': _phoneCtrl.text,
            'gender': _selectedGender,
            'age': int.tryParse(_ageCtrl.text) ?? 0,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingBusDetails) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Passenger Details'),
          elevation: 0,
          backgroundColor: secondaryColor,
        ),
        backgroundColor: bgColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Details'),
        elevation: 0,
        backgroundColor: secondaryColor,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Summary',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 1.5.h),
                      if (_busDetails != null &&
                          _busDetails!['route'] != null) ...[
                        _buildSummaryRow(
                          'Route',
                          '${_busDetails!['route']['origin']} → ${_busDetails!['route']['destination']}',
                        ),
                        SizedBox(height: 1.h),
                      ],
                      _buildSummaryRow(
                        'Selected Seats',
                        widget.selectedSeats.join(', '),
                      ),
                      SizedBox(height: 1.h),
                      _buildSummaryRow(
                        'Number of Passengers',
                        '${widget.selectedSeats.length}',
                      ),
                      SizedBox(height: 1.h),
                      if (_busDetails != null &&
                          _busDetails!['seatConfig'] != null) ...[
                        Divider(color: Colors.white24),
                        SizedBox(height: 1.h),
                        _buildSummaryRow(
                          'Available Seats',
                          '${_busDetails!['seatConfig']['availableSeats']}',
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 2.5.h),
                Text(
                  'Full Name *',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.8.h),
                _buildTextField(
                  controller: _fullNameCtrl,
                  hintText: 'Enter full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  'WhatsApp Number *',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.8.h),
                _buildTextField(
                  controller: _phoneCtrl,
                  hintText: 'Enter 10-digit phone number',
                  prefixText: '+91 ',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your WhatsApp number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  'Email Address *',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.8.h),
                Text(
                  'Gender *',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.8.h),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: _genders.map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select gender',
                    filled: true,
                    fillColor: secondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: secondaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  'Age *',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.8.h),
                _buildTextField(
                  controller: _ageCtrl,
                  hintText: 'Enter age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Proceed to Payment',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? prefixText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixText: prefixText,
        prefixStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

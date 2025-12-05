import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/models/api_response.dart';
import '../../core/services/http_service.dart';
import '../../core/utility/logger.dart';
import '../../core/utility/notification_helper.dart';
import '../../core/utility/utils.dart';
import '../../common/models/user/user_model.dart';
import '../../common/models/vendor/vendor_model.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage;
  final HttpService _httpService;

  AuthService({
    required FlutterSecureStorage secureStorage,
    required HttpService httpService,
  }) : _secureStorage = secureStorage,
       _httpService = httpService;

  // Helper method to store authentication data
  Future<void> _storeAuthData(String type, dynamic data) async {
    Logger.info('_storeAuthData data = $data');
    Logger.info('_storeAuthData data?.token = ${data?.token}');
    await _secureStorage.write(key: '${type}_auth_token', value: data?.token);
    await _secureStorage.write(key: '${type}_data', value: jsonEncode(data));
  }

  // User authentication
  Future<bool> authenticate(String email, String password) async {
    try {
      final response = await _httpService.addItem(
        endpointUrl: 'users/login',
        itemData: {"email": email.toLowerCase(), "password": password},
      );

      if (response.isOk) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        final apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );

        if (apiResponse.success) {
          Logger.info('authenticate apiResponse.data = $response');
          await _storeAuthData('admin', apiResponse.data);
          NotificationHelper.showSuccessNotification(apiResponse.message);
          return true;
        }
        NotificationHelper.showErrorNotification(
          'Failed to Login: ${apiResponse.message}',
        );
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
          'Error ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      print('Error occurred during login: $e');
      NotificationHelper.showErrorNotification('An error occurred: $e');
    }
    return false;
  }

  Future<bool> register(String userName, String email, String password) async {
    try {
      final response = await _httpService.addItem(
        endpointUrl: 'users/register',
        itemData: {
          "name": userName,
          "email": email,
          "password": password,
          "role": "ADMIN",
        },
      );

      if (response.isOk) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        final apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );

        if (apiResponse.success) {
          // await _storeAuthData('user', apiResponse.data);
          NotificationHelper.showSuccessNotification(apiResponse.message);
          return true;
        }
        NotificationHelper.showErrorNotification(
          'Failed to Register: ${apiResponse.message}',
        );
      } else {
        print('else: ${response.body}');
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
          'Error ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      print('catch: ${e}');
      print('Error occurred during registration: $e');
      NotificationHelper.showErrorNotification('An error occurred: $e');
    }
    return false;
  }

  // Simulate password reset (forgot password)
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate checking for a valid email and sending a reset email
    if (email == "user@example.com") {
      // In a real-world scenario, you would send an email to the user
      return true;
    }
    return false;
  }

  // Logout user
  Future<void> logoutFromServer() async {
    // log('logoutFromServer');
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<bool> isAuthenticated() async {
    final userToken = await _secureStorage.read(key: 'user_auth_token');
    final vendorToken = await _secureStorage.read(key: 'vendor_auth_token');
    return userToken != null || vendorToken != null;
  }

  Future<dynamic> getStoredUser(String type) async {
    final userData = await _secureStorage.read(key: '${type}_data');

    if ((type == 'user' || type == 'admin') && !Utils.isEmpty(userData)) {
      return UserModel.fromJson(jsonDecode(userData!));
    } else if (type == 'user' && !Utils.isEmpty(userData)) {
      return VendorModel.fromJson(jsonDecode(userData!));
    }
    return null;
  }
}

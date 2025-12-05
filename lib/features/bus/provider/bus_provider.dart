import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core_lib/core.dart';

import '../model/bus_state_model.dart';

part 'bus_provider.g.dart';

@Riverpod(keepAlive: true)
class Bus extends _$Bus {
  @override
  BusStateModel build() {
    _httpService = ref.read(httpServiceProvider);
    _dataNotifier = ref.read(dataProvider.notifier);
    _authNotifier = ref.read(authProvider.notifier);
    return BusStateModel.initial();
  }

  late final HttpService _httpService;
  late final Data _dataNotifier;
  late final AuthNotifier _authNotifier;

  void setBusName(String newBusName) {
    final current = state.busForUpdate;

    if (current != null) {
      state = state.copyWith(
        busForUpdate: current.copyWith(busName: newBusName),
      );
    } else {
      state = state.copyWith(busForUpdate: BusModel(busName: newBusName));
    }
  }

  // Future<void> pickImage() async {
  //   final file = await FilePickerUtils.pickImage();
  //   if (file != null) {
  //     state = state.copyWith(selectedImage: file);
  //   }
  // }

  submitBus() {
    // Check if the busForUpdate has a valid busId
    if (state.busForUpdate != null &&
        state.busForUpdate!.busId != null &&
        state.busForUpdate!.busId! > 0) {
      updateBus(); // Update if busId is present
    } else {
      addBus(); // Add a new _httpService type if no valid ID
    }
  }

  Future<void> addBus() async {
    Logger.info('addBus called');
    try {
      // if (state.selectedImage == null) {
      //   NotificationHelper.showErrorNotification('Please Choose An Image!');
      //   return;
      // }
      if (state.busForUpdate == null) {
        NotificationHelper.showErrorNotification('Bus data is missing!');
        return;
      }

      // final formData = {
      //   'name': state.busForUpdate?.busName ?? '',
      //   'operator': state.busForUpdate?.busOperator ?? '',
      //   'fromCity': state.busForUpdate?.busFromCity ?? '',
      //   'toCity': state.busForUpdate?.busToCity ?? '',
      //   'departureTime':
      //       Utils.formatToApiTime(state.busForUpdate?.busDepartureTime) ?? '',
      //   'arrivalTime':
      //       Utils.formatToApiTime(state.busForUpdate?.busArrivalTime) ?? '',
      //   'price': state.busForUpdate?.busPrice.toString() ?? '0',
      //   'totalSeats': state.busForUpdate?.busTotalSeats.toString() ?? '0',
      //   'availableSeats':
      //       state.busForUpdate?.busAvailableSeats.toString() ?? '0',
      //   // stoppages: map the list (if null -> empty list)
      //   'stoppages':
      //       state.busForUpdate?.busStoppages
      //           ?.map(
      //             (s) => {
      //               'cityName': s.cityName ?? '',
      //               'arrivalTime': Utils.formatToApiTime(s.arrivalTime) ?? '',
      //               'departureTime':
      //                   Utils.formatToApiTime(s.departureTime) ?? '',
      //               'cumulativePrice': s.cumulativePrice ?? 0,
      //             },
      //           )
      //           .toList() ??
      //       [],
      // };

      final formData = state.busForUpdate!.toJson();
      Logger.info('addBus formData = $formData');

      final userToken = await _authNotifier.user.token;
      Logger.info('addBus userToken = $userToken');

      final response = await _httpService.addItem(
        endpointUrl: 'buses/register',
        headers: {"Authorization": "Bearer $userToken"},
        itemData: formData,
      );

      // Upload file and fields
      // final response = await _httpService.uploadFiles(
      //   endpointUrl: 'buses/register',
      //   headers: {"Authorization": "Bearer $userToken"},
      //   fields: formData,
      //   files: [state.selectedImage!], // Must be PlatformFile
      //   fileFieldName: 'img', // This should match your backend field name
      // );

      if (response.isOk) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        // final responseBody = await response.stream.bytesToString();
        // final jsonMap = jsonDecode(responseBody) as Map<String, dynamic>;

        ApiResponse apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => null,
        );

        if (apiResponse.success == true) {
          await _dataNotifier.getAllBus();
          NotificationHelper.showSuccessNotification(apiResponse.message);
        } else {
          NotificationHelper.showErrorNotification(
            'Failed to add bus: ${apiResponse.message}',
          );
        }
      } else {
        final errorBody = jsonDecode(response.body);
        // final errorBody = await response.stream.bytesToString();
        // final jsonError = jsonDecode(errorBody);
        NotificationHelper.showErrorNotification(
          'Error: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      NotificationHelper.showErrorNotification('An error occurred: $e');
      rethrow;
    } finally {
      clearFields();
    }
  }

  Future<void> updateBus() async {
    Logger.info('updateBus called');
    try {
      final bus = state.busForUpdate;

      if (bus == null) {
        NotificationHelper.showErrorNotification('Missing bus data!');
        return;
      }

      // final Map<String, String> formData = {
      //   'name': bus.busName ?? '',
      //   'operator': bus.busOperator ?? '',
      //   'fromCity': bus.busFromCity ?? '',
      //   'toCity': bus.busToCity ?? '',
      //   'departureTime': bus.busDepartureTime ?? '',
      //   'arrivalTime': bus.busArrivalTime ?? '',
      //   'price': bus.busPrice.toString(),
      //   'totalSeats': bus.busTotalSeats.toString(),
      //   'availableSeats': bus.busAvailableSeats.toString(),
      // };
      // http.StreamedResponse response;

      // if (state.selectedImage != null) {
      //   // If image is selected, send as multipart with file
      //   response = await _httpService.uploadFiles(
      //     endpointUrl: 'bus/${bus.busId}',
      //     method: HttpMethod.put,
      //     fields: formData,
      //     files: [state.selectedImage!],
      //     fileFieldName: 'img',
      //   );
      // } else {
      // If no image selected, send as simple JSON PUT

      final formData = state.busForUpdate!.toJson();
      Logger.info('addBus formData = $formData');

      final userToken = await _authNotifier.user.token;
      Logger.info('updateBus userToken = $userToken');

      final response = await _httpService.updateItem(
        endpointUrl: 'buses',
        headers: {"Authorization": "Bearer $userToken"},
        itemId: bus.busId.toString(),
        itemData: formData,
      );
      if (response.isOk) {
        // final responseBody = await response.stream.bytesToString();
        // final jsonMap = jsonDecode(responseBody) as Map<String, dynamic>;

        // }

        // final respStr = await response.stream.bytesToString();
        // final jsonResp = jsonDecode(respStr);

        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        ApiResponse apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => null,
        );
        if (apiResponse.success == true) {
          await _dataNotifier.getAllBus();
          NotificationHelper.showSuccessNotification(apiResponse.message);
        } else {
          NotificationHelper.showErrorNotification(
            'Failed to add bus: ${apiResponse.message}',
          );
        }
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
          'Error: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      NotificationHelper.showErrorNotification('Error occurred: $e');
    } finally {
      clearFields();
    }
  }

  Future<void> deleteBus(BusModel busModel) async {
    try {
      final userToken = await _authNotifier.user.token;
      Logger.info('deleteBus userToken = $userToken');

      final response = await _httpService.deleteItem(
        endpointUrl: 'buses',
        headers: {"Authorization": "Bearer $userToken"},
        itemId: busModel.busId.toString(),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        ApiResponse apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => null,
        );
        if (apiResponse.success == true) {
          await _dataNotifier.getAllBus();

          NotificationHelper.showSuccessNotification(
            'Bus Deleted Successfully',
          );
        }
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
          'Error: ${errorBody['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      NotificationHelper.showErrorNotification('An Error occured: $e');
      rethrow;
    }
  }

  //? set data for update on editing
  void setDataForUpdateBus(BusModel? busModel) {
    if (busModel == null) {
      return;
    }

    state = state.copyWith(busForUpdate: busModel);
  }

  void clearFields() {
    state = BusStateModel.initial();
  }
}

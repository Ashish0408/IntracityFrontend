import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../dependencies/app_dependencies.dart';
import '../constants/constants.dart';
import '../utility/logger.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.httpService;
});

extension HttpResponseExtension on http.Response {
  bool get isOk => statusCode >= 200 && statusCode < 300;
  dynamic get decodedBody {
    try {
      return json.decode(body);
    } catch (_) {
      return body;
    }
  }
}

extension StreamedResponseExtension on http.StreamedResponse {
  bool get isOk => statusCode >= 200 && statusCode < 300;
}

enum HttpMethod { get, post, put, patch, delete }

extension HttpMethodExtension on HttpMethod {
  String get name => toString().split('.').last.toUpperCase();
}

//USAGE
// final httpService = ref.read(httpServiceProvider);
// final response = await httpService.getItems(endpointUrl: 'your-endpoint');

class HttpService {
  final String baseUrl = MAIN_URL;

  // Private method for shared headers
  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
  };

  /// ✅ Merge default headers & custom headers
  Future<Map<String, String>> _mergeHeaders([
    Map<String, String>? customHeaders,
  ]) async {
    final defaultHeaders = await _defaultHeaders;
    return {...defaultHeaders, ...?customHeaders};
  }

  Future<http.Response> getItems({
    required String endpointUrl,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(() async {
      final uri = Uri.parse('$baseUrl/$endpointUrl');
      Logger.info('getItems uri = $uri');
      Logger.info('getItems headers = $headers');
      final header = await _mergeHeaders(headers);
      Logger.info('getItems header = $header');
      return http.get(uri, headers: header);
    });
  }

  Future<http.Response> getItemsWithQueryParams({
    required String endpointUrl,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/$endpointUrl',
    ).replace(queryParameters: queryParams);

    return _handleRequest(() async {
      return http.get(uri, headers: await _mergeHeaders(headers));
    });
  }

  Future<http.Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(() async {
      return http.post(
        Uri.parse('$baseUrl/$endpointUrl'),
        body: json.encode(itemData),
        headers: await _mergeHeaders(headers),
      );
    });
  }

  Future<http.Response> updateItem({
    required String endpointUrl,
    required String itemId,
    required dynamic itemData,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(() async {
      return http.put(
        Uri.parse('$baseUrl/$endpointUrl/$itemId'),
        body: json.encode(itemData),
        headers: await _mergeHeaders(headers),
      );
    });
  }

  Future<http.Response> deleteItem({
    required String endpointUrl,
    required String itemId,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(() async {
      return http.delete(
        Uri.parse('$baseUrl/$endpointUrl/$itemId'),
        headers: await _mergeHeaders(headers),
      );
    });
  }

  // Private method for handling requests
  Future<http.Response> _handleRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();
      // Logger.info('_handleRequest requestFunction = $requestFunction');
      Logger.info('_handleRequest body = ${response.body}');
      return response;
    } catch (e) {
      Logger.info('HTTP ERROR: $e');
      return http.Response(json.encode({'message': 'Error: $e'}), 500);
    }
  }

  /// ✅ Generic method to upload files with form fields
  /// Upload one or more files with form fields using POST, PUT, or PATCH
  /// ✅ Multipart Upload with Token
  Future<http.StreamedResponse> uploadFiles({
    required String endpointUrl,
    required Map<String, String> fields,
    required List<PlatformFile> files,
    HttpMethod method = HttpMethod.post,
    String fileFieldName = 'file',
    List<MediaType>? contentTypes,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpointUrl');
    final request = http.MultipartRequest(method.name, uri)
      ..fields.addAll(fields)
      ..headers.addAll(await _mergeHeaders(headers));

    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      final mediaType = contentTypes != null && i < contentTypes.length
          ? contentTypes[i]
          : _resolveMediaType(file.name);

      if (kIsWeb && file.bytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            fileFieldName,
            file.bytes!,
            filename: file.name,
            contentType: mediaType,
          ),
        );
      } else if (file.path != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            fileFieldName,
            file.path!,
            contentType: mediaType,
          ),
        );
      }
    }

    return await request.send();
  }

  Future<http.StreamedResponse> uploadFormOnly({
    required String endpointUrl,
    required HttpMethod method,
    required Map<String, String> fields,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpointUrl');
    final request = http.MultipartRequest(method.name, uri)
      ..fields.addAll(fields);
    return await request.send();
  }

  /// Auto-detect media type based on file extension (fallback = octet-stream)
  MediaType _resolveMediaType(String filename) {
    final mime = lookupMimeType(filename) ?? 'application/octet-stream';
    final parts = mime.split('/');
    return MediaType(parts[0], parts[1]);
  }

  Future<void> addService({
    required String serviceTypeId,
    required String serviceSubTypeId,
    required String serviceName,
    required String serviceDescription,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/service'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "serviceTypeId": serviceTypeId,
        "serviceSubTypeId": serviceSubTypeId,
        "serviceName": serviceName,
        "serviceDescription": serviceDescription,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add service');
    }
  }
}

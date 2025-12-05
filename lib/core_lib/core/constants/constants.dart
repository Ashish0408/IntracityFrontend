import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const defaultPadding = 16.0;

// const MAIN_URL = 'http://localhost:3000';
// const MAIN_URL = 'https://kirmad.com/api';
// const MAIN_URL = 'http://192.168.29.134:9090/api';

// const MAIN_URL = 'https://intracity.onrender.com/api';
// const MAIN_URL = 'http://localhost:8080/api';
// const MAIN_URL = 'http://192.168.29.134:8081/api';

const MAIN_URL = 'https://intracity.onrender.com/api';

// FlutterSecureStorage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

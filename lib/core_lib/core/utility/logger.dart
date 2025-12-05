import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:ansicolor/ansicolor.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Logger {
  static final AnsiPen _infoPen = AnsiPen()..cyan();
  static final AnsiPen _errorPen = AnsiPen()..red();
  static final AnsiPen _successPen = AnsiPen()..green();
  static final AnsiPen _warningPen = AnsiPen()..yellow();

  static Map<String, String>? deviceInfo;

  /// Preload device info (call once in app init)
  static Future<void> initDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> info = {};

    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      info = {
        'browser': webInfo.browserName.name,
        'userAgent': webInfo.userAgent ?? 'Unknown',
        'platform': webInfo.platform ?? 'Unknown',
      };
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      info = {
        'brand': androidInfo.brand,
        'model': androidInfo.model,
        'version': androidInfo.version.release,
      };
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      info = {
        'name': iosInfo.name,
        'model': iosInfo.model,
        'systemVersion': iosInfo.systemVersion,
      };
    }

    deviceInfo = info;
  }

  static void _log(
    String message, {
    required String tag,
    required AnsiPen pen,
    int traceLevel = 2,
    int level = 800,
  }) {
    if (kDebugMode) {
      final trace = Trace.current(traceLevel);
      final frame = trace.frames.firstWhere(
        (frame) => frame.package != 'flutter',
        orElse: () => trace.frames[0],
      );

      final file = frame.uri.pathSegments.last;
      final line = frame.line ?? 0;
      final member = frame.member ?? 'Unknown';
      final function = member.split('.').last;
      // final className =
      //     member.contains('.') ? member.split('.').first : 'Unknown';
      final time = DateTime.now().toIso8601String();

      final logMessage = [
        // '[device: ${_deviceInfo != null ? _deviceInfo!.values.join(", ") : "N/A"}]',
        '[$time]',
        '[$tag]',
        // '[class: $className]',
        '[$file:$line]',
        '[$function()]',
        '- $message',
      ].join(' ');

      // Colored log in dev console
      // print(pen(logMessage));

      // IDE developer log
      developer.log(
        pen(logMessage),
        name: 'Logger',
        time: DateTime.now(),
        level: level,
      );
    }
  }

  static void info(String message, {String tag = 'INFO', String? context}) =>
      _log(message, tag: tag, pen: _infoPen);

  static void success(
    String message, {
    String tag = 'SUCCESS',
    String? context,
  }) => _log(message, tag: tag, pen: _successPen);

  static void warning(
    String message, {
    String tag = 'WARNING',
    String? context,
  }) => _log(message, tag: tag, pen: _warningPen, level: 900);

  static void error(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
    String? context,
  }) => _log(message, tag: tag, pen: _errorPen, level: 1000);
}

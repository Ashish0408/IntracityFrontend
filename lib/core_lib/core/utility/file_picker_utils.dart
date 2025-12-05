import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Wrapper class to handle file picking across platforms (Web, Android, iOS, Desktop)
class FilePickerUtils {
  /// Pick an image file
  static Future<PlatformFile?> pickImage() async {
    return _pickFile(type: FileType.image);
  }

  /// Pick a video file
  static Future<PlatformFile?> pickVideo() async {
    return _pickFile(type: FileType.video);
  }

  /// Pick a PDF file
  static Future<PlatformFile?> pickPDF() async {
    return _pickFile(type: FileType.custom, allowedExtensions: ['pdf']);
  }

  /// Pick any type of file
  static Future<PlatformFile?> pickAnyFile() async {
    return _pickFile(type: FileType.any);
  }

  /// Internal generic method for picking files
  static Future<PlatformFile?> _pickFile({
    required FileType type,
    List<String>? allowedExtensions,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowMultiple: false,
        allowedExtensions: allowedExtensions,
        withData: kIsWeb, // Needed to access bytes on web
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.first;
      }
      return null;
    } catch (e) {
      print("Error picking file: $e");
      return null;
    }
  }

  /// Get file bytes (for upload or display)
  static Future<Uint8List?> getFileBytes(PlatformFile file) async {
    if (kIsWeb) return file.bytes;
    if (file.path != null) return File(file.path!).readAsBytes();
    return null;
  }

  /// Get file path (useful for native apps)
  static String? getFilePath(PlatformFile file) {
    return file.path;
  }
}

// For picking an image:
//      final pickedFile = await FilePickerUtils.pickImage();

// For getting bytes (useful for MultipartFile.fromBytes):
//      final bytes = await FilePickerUtils.getFileBytes(pickedFile!);

// For getting file path (useful for native MultipartFile.fromPath):
//      final path = FilePickerUtils.getFilePath(pickedFile!);

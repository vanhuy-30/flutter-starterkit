import 'dart:io';
import 'dart:isolate';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class FileService {
  static final FileService _instance = FileService._internal();
  factory FileService() => _instance;
  FileService._internal();

  final Dio _dio = Dio();
  bool _isInitialized = false;

  Future<T> _runFileOperation<T>(T Function() operation) {
    return Isolate.run(operation);
  }

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  // Request storage permission
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  // Get temporary directory
  Future<Directory> getTemporaryDirectory() async {
    return path_provider.getTemporaryDirectory();
  }

  // Get application documents directory
  Future<Directory> getApplicationDocumentsDirectory() async {
    return path_provider.getApplicationDocumentsDirectory();
  }

  // Get application support directory
  Future<Directory> getApplicationSupportDirectory() async {
    return path_provider.getApplicationSupportDirectory();
  }

  // Get external storage directory
  Future<Directory?> getExternalStorageDirectory() async {
    return path_provider.getExternalStorageDirectory();
  }

  // Download file
  Future<String> downloadFile({
    required String url,
    required String fileName,
    String? directory,
    void Function(int, int)? onProgress,
  }) async {
    try {
      // Request storage permission
      final hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Get download directory
      final targetDirectoryPath =
          directory ?? (await getApplicationDocumentsDirectory()).path;

      final directoryExists = await _runFileOperation(
        () => Directory(targetDirectoryPath).existsSync(),
      );

      if (!directoryExists) {
        await _runFileOperation(() {
          Directory(targetDirectoryPath).createSync(recursive: true);
          return true;
        });
      }

      // Create file path
      final filePath = path.join(targetDirectoryPath, fileName);

      // Download file
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
      );

      return filePath;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      rethrow;
    }
  }

  // Upload file
  Future<Map<String, dynamic>> uploadFile({
    required String filePath,
    required String url,
    Map<String, dynamic>? formData,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final fileExists = await _runFileOperation(
        () => File(filePath).existsSync(),
      );
      if (!fileExists) {
        throw Exception('File not found');
      }

      // Create form data
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        ...?formData,
      });

      // Upload file
      final response = await _dio.post(
        url,
        data: form,
        onSendProgress: onProgress,
      );

      return response.data;
    } catch (e) {
      debugPrint('Error uploading file: $e');
      rethrow;
    }
  }

  // Delete file
  Future<void> deleteFile(String filePath) async {
    try {
      await _runFileOperation(() {
        final file = File(filePath);
        if (file.existsSync()) {
          file.deleteSync();
        }
        return true;
      });
    } catch (e) {
      debugPrint('Error deleting file: $e');
      rethrow;
    }
  }

  // Get file size
  Future<int> getFileSize(String filePath) async {
    try {
      return await _runFileOperation(() {
        final file = File(filePath);
        if (file.existsSync()) {
          return file.lengthSync();
        }
        return 0;
      });
    } catch (e) {
      debugPrint('Error getting file size: $e');
      return 0;
    }
  }

  // Get file extension
  String getFileExtension(String filePath) {
    return path.extension(filePath);
  }

  // Get file name
  String getFileName(String filePath) {
    return path.basename(filePath);
  }

  // Check if file exists
  Future<bool> fileExists(String filePath) async {
    try {
      return _runFileOperation(() => File(filePath).existsSync());
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }

  // Create directory
  Future<void> createDirectory(String directoryPath) async {
    try {
      await _runFileOperation(() {
        final directory = Directory(directoryPath);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
        return true;
      });
    } catch (e) {
      debugPrint('Error creating directory: $e');
      rethrow;
    }
  }

  // List directory contents
  Future<List<FileSystemEntity>> listDirectory(String directoryPath) async {
    try {
      return await _runFileOperation(() {
        final directory = Directory(directoryPath);
        if (directory.existsSync()) {
          return directory.listSync();
        }
        return <FileSystemEntity>[];
      });
    } catch (e) {
      debugPrint('Error listing directory: $e');
      return [];
    }
  }
}

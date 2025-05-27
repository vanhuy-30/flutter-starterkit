import 'dart:io';
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
    return await path_provider.getTemporaryDirectory();
  }

  // Get application documents directory
  Future<Directory> getApplicationDocumentsDirectory() async {
    return await path_provider.getApplicationDocumentsDirectory();
  }

  // Get application support directory
  Future<Directory> getApplicationSupportDirectory() async {
    return await path_provider.getApplicationSupportDirectory();
  }

  // Get external storage directory
  Future<Directory?> getExternalStorageDirectory() async {
    return await path_provider.getExternalStorageDirectory();
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
      final downloadDir = directory != null
          ? Directory(directory)
          : await getApplicationDocumentsDirectory();
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      // Create file path
      final filePath = path.join(downloadDir.path, fileName);

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
      final file = File(filePath);
      if (!await file.exists()) {
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
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
      rethrow;
    }
  }

  // Get file size
  Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
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
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }

  // Create directory
  Future<void> createDirectory(String directoryPath) async {
    try {
      final directory = Directory(directoryPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    } catch (e) {
      debugPrint('Error creating directory: $e');
      rethrow;
    }
  }

  // List directory contents
  Future<List<FileSystemEntity>> listDirectory(String directoryPath) async {
    try {
      final directory = Directory(directoryPath);
      if (await directory.exists()) {
        return await directory.list().toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error listing directory: $e');
      return [];
    }
  }
} 
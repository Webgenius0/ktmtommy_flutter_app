import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  final Dio _dio = Dio();
  bool _isDownloading = false;
  double _downloadProgress = 0;

  bool get isDownloading => _isDownloading;
  double get downloadProgress => _downloadProgress;

  Future<void> downloadFile({
    required String url,
    required String fileName,
    required BuildContext context,
    VoidCallback? onStart,
    ValueChanged<double>? onProgress,
    VoidCallback? onComplete,
    ValueChanged<String>? onError,
  }) async {
    // Request permissions
    if (!await _requestPermissions()) {
      onError?.call('Storage permission denied');
      return;
    }

    // Update state
    _isDownloading = true;
    _downloadProgress = 0;
    onStart?.call();

    try {
      // Get the correct downloads directory
      final directory = await _getProperDownloadDirectory();
      final filePath = '${directory.path}/$fileName';

      // Download the file
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          _downloadProgress = received / total;
          onProgress?.call(_downloadProgress);
        },
      );

      // Verify the file
      final file = File(filePath);
      final exists = await file.exists();
      if (!exists) throw Exception('File not saved properly');

      // Show confirmation dialog
      final shouldOpen = await showDialog<bool>(
        context: context,
        builder: (context) => _buildDownloadCompleteDialog(context),
      ) ?? false;

      // Open file if user selected Yes
      if (shouldOpen) {
        await _openDownloadedFile(filePath, context);
      }

      onComplete?.call();
    } catch (e) {
      debugPrint('Download error: $e');
      onError?.call('Download failed: ${e.toString()}');
    } finally {
      _isDownloading = false;
    }
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isDenied) return false;
      if (await Permission.manageExternalStorage.request().isDenied) return false;
    }
    return true;
  }

  Future<Directory> _getProperDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Try to get public downloads directory first
      final publicDir = await getExternalStorageDirectory();
      if (publicDir != null) {
        final downloadsDir = Directory('${publicDir.path}/Download');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        return downloadsDir;
      }
    }
    // Fallback to internal directory
    return getApplicationDocumentsDirectory();
  }

  Future<void> _openDownloadedFile(String filePath, BuildContext context) async {
    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open file: ${result.message}')),
      );
    }
  }

  Widget _buildDownloadCompleteDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        'Download Complete',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        'The file has been downloaded successfully. Do you want to open it now?',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context, false),
          child: const Text('LATER'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('OPEN NOW'),
        ),
      ],
    );
  }
}
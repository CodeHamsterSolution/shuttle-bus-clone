import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mmu_shuttle_driver/core/constants.dart';
import 'package:mmu_shuttle_driver/core/network/api.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<Uint8List> fetchFile(String fileName) async {
    try {
      final response = await dio.get(
        "/file/$fileName",
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception(DEFAULT_ERROR_MESSAGE);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final List<int> responseBytes = List<int>.from(e.response!.data);

          final String errorJsonString = utf8.decode(responseBytes);
          final Map<String, dynamic> errorData = jsonDecode(errorJsonString);

          throw Exception(errorData['message'] ?? DEFAULT_ERROR_MESSAGE);
        } on DioException catch (e) {
          throw Exception(e.error);
        } catch (e) {
          throw Exception(DEFAULT_ERROR_MESSAGE);
        }
      }
      throw Exception(DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<File> saveFile(String filename, Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

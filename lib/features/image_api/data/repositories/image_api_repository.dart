import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:api_integration/config/base_url.dart';
import 'package:api_integration/features/image_api/data/models/image_api_model.dart';

import 'package:http/http.dart' as http;

import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';
import 'package:api_integration/features/image_api/domain/repositories/image_api_repository.dart';


class PhotoRepositoryImpl implements IPhotoRepository {
 

  @override
Future<List<PhotoEntity>> getPhotos() async {
  try {
    final response = await http.get(Uri.parse(BaseUrls.photosApi)); 

    // final response = await http.get(
    //   Uri.parse(baseUrl),
    //   headers: {
    //     "Accept": "application/json",
    //     "Content-Type": "application/json",
    //   },
    // );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      if (jsonList.isEmpty) {
        log("API returned empty list");
        return [];
      }

      return jsonList
          .map((json) => PhotoModel.fromJson(json).toEntity())
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized. Check your API key or token.");
    } else if (response.statusCode == 404) {
      throw Exception("Resource not found.");
    } else {
      throw Exception(
          "Failed to load photos. Status code: ${response.statusCode}");
    }
  } on SocketException {
    log("No Internet connection");
    throw Exception("No Internet connection. Please try again later.");
  } on FormatException {
    log("Invalid JSON format");
    throw Exception("Invalid data format received from server.");
  } catch (e, stackTrace) {
    log("Unexpected error: $e", stackTrace: stackTrace);
    throw Exception("Something went wrong: $e");
  }
}
}

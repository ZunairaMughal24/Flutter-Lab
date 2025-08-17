import 'dart:convert';
import 'package:api_integration/features/image_api/domain/models/image_api_model.dart';
import 'package:http/http.dart' as http;

import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';
import 'package:api_integration/features/image_api/domain/repositories/image_api_repository.dart';


class PhotoRepositoryImpl implements IPhotoRepository {
  final String baseUrl = "https://picsum.photos/v2/list";

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    final response = await http.get(Uri.parse(baseUrl));

    // final response = await http.get(
    //   Uri.parse(baseUrl),
    //   headers: {
    //     "Accept": "application/json",
    //     "Content-Type": "application/json",
    //   },
    // );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => PhotoModel.fromJson(json).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

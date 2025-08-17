import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';

class PhotoModel {
  final String id;
  final String? author;
  final String? url;

  final int width;
  final int height;

  final String downloadUrl;

  PhotoModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'].toString(),
      author: json['author'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '', // 👈 MUST be this key
    );
  }

  PhotoEntity toEntity() {
    return PhotoEntity(
      id: id,
      author: author ?? "Unknown",
      width: width,
      height: height,
      url: url ?? "unknown",
      downloadUrl: downloadUrl,
    );
  }
}

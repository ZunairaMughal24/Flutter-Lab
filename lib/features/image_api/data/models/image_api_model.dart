import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';
import 'package:equatable/equatable.dart';

class PhotoModel extends Equatable {
  final String id;
  final String? author;
  final String? url;
  final int width;
  final int height;
  final String downloadUrl;

  const PhotoModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  /// Factory constructor from JSON
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'].toString(),
      author: json['author'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }

  /// Convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'width': width,
      'height': height,
      'url': url,
      'download_url': downloadUrl,
    };
  }

  /// Convert to domain entity
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

  /// Convert back from entity to model
  factory PhotoModel.fromEntity(PhotoEntity entity) {
    return PhotoModel(
      id: entity.id,
      author: entity.author,
      width: entity.width,
      height: entity.height,
      url: entity.url,
      downloadUrl: entity.downloadUrl,
    );
  }

  /// Copy with (immutability helper)
  PhotoModel copyWith({
    String? id,
    String? author,
    String? url,
    int? width,
    int? height,
    String? downloadUrl,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      author: author ?? this.author,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  /// Pretty print for debugging
  @override
  String toString() {
    return '''
    PhotoModel(
      id: $id,
      author: $author,
      url: $url,
      width: $width,
      height: $height,
      downloadUrl: $downloadUrl
    )
    ''';
  }

  /// Required for Equatable
  @override
  List<Object?> get props => [id, author, url, width, height, downloadUrl];
}

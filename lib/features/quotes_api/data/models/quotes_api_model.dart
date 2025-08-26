// =======================
// Quote DTO (for API parsing)
// =======================
import 'package:api_integration/features/quotes_api/domain/entities/quote_entity.dart';

class QuoteModel {
  final String quote; // Quote text
  final String author; // Author
  final String c; // Character count (string in API)
  final String h; // HTML formatted quote

  QuoteModel({
    required this.quote,
    required this.author,
    required this.c,
    required this.h,
  });

  // Parse JSON to DTO
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['q'] ?? '',
      author: json['a'] ?? '',
      c: json['c'] ?? '',
      h: json['h'] ?? '',
    );
  }

  // Convert DTO back to JSON (useful for caching)
  Map<String, dynamic> toJson() {
    return {
      'q': quote,
      'a': author,
      'c': c,
      'h': h,
    };
  }

  // Convert DTO -> Entity
  QuoteEntity toEntity() {
    return QuoteEntity(
      quote: quote,
      author: author,
      charCount: int.tryParse(c) ?? 0,
      htmlQuote: h,
    );
  }
}



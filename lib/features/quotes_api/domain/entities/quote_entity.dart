/// Entity class - pure business logic layer (independent of API/DB)
// =======================
// Entity Class (for app domain layer)
// =======================
class QuoteEntity {
  final String quote;
  final String author;
  final int charCount;
  final String htmlQuote;

  QuoteEntity({
    required this.quote,
    required this.author,
    required this.charCount,
    required this.htmlQuote,
  });

  // Useful copyWith method
  QuoteEntity copyWith({
    String? quote,
    String? author,
    int? charCount,
    String? htmlQuote,
  }) {
    return QuoteEntity(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      charCount: charCount ?? this.charCount,
      htmlQuote: htmlQuote ?? this.htmlQuote,
    );
  }

  @override
  String toString() {
    return '"$quote" — $author';
  }
}
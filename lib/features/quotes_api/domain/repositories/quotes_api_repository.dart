import 'package:api_integration/features/quotes_api/data/models/quotes_api_model.dart';
import 'package:api_integration/features/quotes_api/domain/entities/quote_entity.dart';

abstract class QuoteRepository {
  Future<QuoteEntity> fetchRandomQuote();
}
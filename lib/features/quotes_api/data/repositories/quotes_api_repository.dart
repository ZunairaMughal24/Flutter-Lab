import 'dart:convert';
import 'package:api_integration/config/base_url.dart';
import 'package:api_integration/features/quotes_api/data/models/quotes_api_model.dart';
import 'package:api_integration/features/quotes_api/domain/entities/quote_entity.dart';
import 'package:api_integration/features/quotes_api/domain/repositories/quotes_api_repository.dart';
import 'package:http/http.dart' as http;


class QuoteRepositoryImpl implements QuoteRepository {


  @override
  Future<QuoteEntity> fetchRandomQuote() async {
    try {
      final response = await http.get(Uri.parse(BaseUrls.quoteApi));
       

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);

  
          if (data is List && data.isNotEmpty) {
            return QuoteModel.fromJson(data[0]).toEntity();
          } else {
            throw Exception("Unexpected data format from API");
          }

        case 400:
          throw Exception("Bad request. Please try again later.");
        case 401:
          throw Exception("Unauthorized. Check your API key if required.");
        case 403:
          throw Exception("Forbidden request.");
        case 404:
          throw Exception("Quote API endpoint not found.");
        case 500:
          throw Exception("Server error. Please try again later.");
        default:
          throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching quote: $e");
    }
  }
}

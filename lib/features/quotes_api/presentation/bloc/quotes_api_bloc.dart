import 'package:api_integration/features/quotes_api/domain/repositories/quotes_api_repository.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quote_events.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quotes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository repository;

  QuoteBloc(this.repository) : super(QuoteInitial()) {
    on<FetchQuoteEvent>((event, emit) async {
      emit(QuoteLoading());
      try {
        final quote = await repository.fetchRandomQuote();
        emit(QuoteLoaded(quote));
      } catch (e) {
        emit(QuoteError(e.toString()));
      }
    });
  }
}

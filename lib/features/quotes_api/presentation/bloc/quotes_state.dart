import 'package:api_integration/features/quotes_api/data/models/quotes_api_model.dart';
import 'package:api_integration/features/quotes_api/domain/entities/quote_entity.dart';
import 'package:equatable/equatable.dart';


abstract class QuoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final QuoteEntity quote;
  QuoteLoaded(this.quote);

  @override
  List<Object?> get props => [quote];
}

class QuoteError extends QuoteState {
  final String message;
  QuoteError(this.message);

  @override
  List<Object?> get props => [message];
}

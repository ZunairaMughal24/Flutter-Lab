import 'package:equatable/equatable.dart';

abstract class QuoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchQuoteEvent extends QuoteEvent {}

import 'package:api_integration/features/quotes_api/data/repositories/quotes_api_repository.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quote_events.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quotes_api_bloc.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quotes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteBloc(QuoteRepositoryImpl())..add(FetchQuoteEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Random Quote"),
          centerTitle: true,
        ),
        body: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuoteLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '"${state.quote.quote}"',
                        style: const TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "- ${state.quote.author}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<QuoteBloc>().add(FetchQuoteEvent());
                        },
                        child: const Text("New Quote"),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is QuoteError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return const Center(child: Text("Press button to load a quote"));
          },
        ),
      ),
    );
  }
}

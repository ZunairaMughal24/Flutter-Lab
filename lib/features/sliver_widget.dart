import 'package:api_integration/features/image_api/data/repositories/image_api_repository.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_api_bloc.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_states.dart';
import 'package:api_integration/features/quotes_api/data/repositories/quotes_api_repository.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quote_events.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quotes_api_bloc.dart';
import 'package:api_integration/features/quotes_api/presentation/bloc/quotes_state.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverDemo extends StatelessWidget {
  const SliverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              QuoteBloc(QuoteRepositoryImpl())..add(FetchQuoteEvent()),
        ),
        BlocProvider(create: (context) => PhotoBloc(PhotoRepositoryImpl())),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Icon(Icons.menu, color: Colors.black),
              title: const Text("Quotes Of the Day"),
              expandedHeight: 300,
              floating: false,
              automaticallyImplyLeading: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // title: const Text("Sliver Demo"),
                background: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(15),
                    child: Opacity(
                      opacity: 0.9,
                      child: Image.network(
                        //*to give black overlay
                        // color: Colors.black.withOpacity(0.4),
                        // colorBlendMode: BlendMode.darken,
                        "https://picsum.photos/800/400",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            BlocBuilder<QuoteBloc, QuoteState>(
              builder: (context, state) {
                if (state is QuoteLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is QuoteLoaded) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 201, 220, 238),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '"${state.quote.quote}"',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "- ${state.quote.author}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_left,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Previous quote not implemented.',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    context.read<QuoteBloc>().add(
                                      FetchQuoteEvent(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is QuoteError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "Error: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuoteBloc>().add(FetchQuoteEvent());
                        },
                        child: const Text("Fetch Quote"),
                      ),
                    ),
                  );
                }
              },
            ),

            BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                final quoteState = context.watch<QuoteBloc>().state;
                String? author;
                if (quoteState is QuoteLoaded) {
                  author = quoteState.quote.author;
                }
                if (state is PhotoLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is PhotoLoaded) {
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final photo = state.photos[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(
                              255,
                              10,
                              44,
 71,
                            ).withOpacity(0.6),
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Image.network(
                                  photo.downloadUrl,

                                  height: 200,
                                  fit: BoxFit.cover,
                                  color: const Color.fromARGB(
                                    255,
                                    10,
                                    44,
                                    71,
                                  ).withOpacity(0.6),
                                  colorBlendMode: BlendMode.darken,
                                ),
                                if (author != null)
                                  Positioned(
                                    top: 80,
                                    left: 8,
                                    right: 8,
                                    child: Text(
                                      author,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,

                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, childCount: state.photos.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                  );
                } else if (state is PhotoError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "Error: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<PhotoBloc>().add(LoadPhotosEvent());
                        },
                        child: const Text("Load Photos"),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

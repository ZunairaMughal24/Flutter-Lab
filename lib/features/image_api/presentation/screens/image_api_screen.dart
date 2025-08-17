import 'dart:developer';
import 'package:api_integration/features/image_api/data/repositories/image_api_repository.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_api_bloc.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_events.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_states.dart';
import 'package:api_integration/utils/app_colors.dart';
import 'package:api_integration/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(PhotoRepositoryImpl()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            "Image Grid",
            style: AppTextTheme.h4(
              color: AppColors.blackColor,
              weight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoInitial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    log(" Fetch button clicked");
                    context.read<PhotoBloc>().add(LoadPhotosEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Fetch Photos",
                    style: AppTextTheme.bodyMedium(
                      color: AppColors.white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else if (state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            photo.downloadUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              log("Error loading image: $error");
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            photo.author,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is PhotoError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: AppTextTheme.bodyMedium(color: AppColors.errorRed),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

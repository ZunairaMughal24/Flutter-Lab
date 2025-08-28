import 'dart:developer';
import 'package:api_integration/core/utils/app_colors.dart';
import 'package:api_integration/core/utils/app_text_theme.dart';
import 'package:api_integration/features/image_api/data/repositories/image_api_repository.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_api_bloc.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_events.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_states.dart';

import 'package:api_integration/widgets/primary_card.dart';
import 'package:api_integration/widgets/primary_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(PhotoRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
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
                  childAspectRatio: 0.90,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              CustomNetworkImage(imageUrl: photo.downloadUrl),

                              Positioned(
                                top: 55,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.8,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: AppColors.errorRed,
                                    ),
                                    onPressed: () {
                                      log("Liked photo id: ${photo.id}");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                photo.author,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextTheme.bodyMedium(
                                  color: AppColors.blackColor,
                                  weight: FontWeight.bold,
                                ).copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${(photo.width % 100) + 20}.00",
                                style: AppTextTheme.bodyMedium(
                                  color: AppColors.primaryColor,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ],
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

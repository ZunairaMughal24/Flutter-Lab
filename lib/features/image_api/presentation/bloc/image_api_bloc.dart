import 'package:bloc/bloc.dart';
import 'package:api_integration/features/image_api/domain/repositories/image_api_repository.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_events.dart';
import 'package:api_integration/features/image_api/presentation/bloc/image_states.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final IPhotoRepository photoRepository;

  PhotoBloc(this.photoRepository) : super(PhotoInitial()) {
    on<LoadPhotosEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await photoRepository.getPhotos();
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError(e.toString()));
      }
    });
  }
}

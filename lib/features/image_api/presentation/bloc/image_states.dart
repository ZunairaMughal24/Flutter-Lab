
import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';
import 'package:equatable/equatable.dart';


abstract class PhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<PhotoEntity> photos;
  PhotoLoaded(this.photos);

  @override
  List<Object?> get props => [photos];
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);

  @override
  List<Object?> get props => [message];
}

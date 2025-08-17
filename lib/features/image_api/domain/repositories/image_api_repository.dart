
import 'package:api_integration/features/image_api/domain/entities/image_entity.dart';


abstract class IPhotoRepository {
  Future<List<PhotoEntity>> getPhotos();
}

import 'package:sales_mgmt/models/image_model.dart';
import 'package:sales_mgmt/resources/db_provider.dart';

class ImageRepo {
  Future<int> insertImage(ImageModel image) {
    return dbProvider.insertImage(image);
  }

  Future<List<ImageModel>> fetchImages() {
    return dbProvider.fetchImages();
  }
}

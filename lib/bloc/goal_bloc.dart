import 'package:rxdart/rxdart.dart';
import 'package:sales_mgmt/constants.dart';
import 'package:sales_mgmt/models/image_model.dart';
import 'package:sales_mgmt/repository/image_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalBloc {
  SharedPreferences prefs;
  ImageRepo _imageRepo = ImageRepo();
  ReplaySubject<List<ImageModel>> _images = ReplaySubject<List<ImageModel>>();

  GoalBloc() {
    _images.add(assetimages);
  }

  Observable<List<ImageModel>> get imageStream => _images.stream;

  Sink<List<ImageModel>> get _imageSink => _images.sink;

  void insertImage(String imagePath) async {
    ImageModel imageN = (ImageModel(imagePath, false, true));
    assetimages.insert(assetimages.length - 1, imageN);
    _imageSink.add(assetimages);
    int i = await _imageRepo.insertImage(imageN);
    print("image insert success $i");
  }

  void fetchImages() async {
    print("lets fetch images");
    List<ImageModel> images = await _imageRepo.fetchImages();
    assetimages.insertAll(assetimages.length - 1, images);
    _imageSink.add(assetimages);
    print("lets fetch images completed");
  }

  void dispsoe() {
    _images.close();
  }
}

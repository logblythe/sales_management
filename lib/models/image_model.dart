import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  String imagePath;
  bool isAsset;
  bool isImage;

  ImageModel(this.imagePath, this.isAsset, this.isImage);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  factory ImageModel.fromDb(Map<String, dynamic> json) {
    return ImageModel(
      json["imagePath"],
      json["isAsset"] == 1,
      json["isImage"] == 1,
    );
  }

  Map<String, dynamic> toMapForDb() {
    return {
      "imagePath": imagePath,
      "isAsset": isAsset ? 1 : 0,
      "isImage": isImage ? 1 : 0,
    };
  }
}

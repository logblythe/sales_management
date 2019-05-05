// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(json['imagePath'] as String, json['isAsset'] as bool,
      json['isImage'] as bool);
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'isAsset': instance.isAsset,
      'isImage': instance.isImage
    };

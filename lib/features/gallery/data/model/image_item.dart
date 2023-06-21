import 'package:json_annotation/json_annotation.dart';

part 'image_item.g.dart';

@JsonSerializable()
class ImageItem {
  final int id;
  final String src;

  ImageItem(this.id, this.src);

  factory ImageItem.fromJson(Map<String, dynamic> json) => _$ImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}
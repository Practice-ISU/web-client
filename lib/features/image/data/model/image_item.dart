import 'package:json_annotation/json_annotation.dart';

part 'image_item.g.dart';

@JsonSerializable()
class ImageItem {
  final int id;
  final String original;
  final String painted;

  ImageItem(this.id, this.original, this.painted);

  factory ImageItem.fromOriginal(int id, String file) => ImageItem(id, file, file);

  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}

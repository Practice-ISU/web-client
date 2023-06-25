import 'package:json_annotation/json_annotation.dart';

part 'image_item.g.dart';

@JsonSerializable()
class ImageItem {
  final int id;
  final String originalFile;
  final String paintedFile;

  ImageItem(this.id, this.originalFile, this.paintedFile);

  factory ImageItem.original(int id, String file) => ImageItem(id, file, file);

  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}

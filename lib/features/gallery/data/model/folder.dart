import 'package:image_hoster/features/gallery/data/model/image_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class Folder {
  final int id;
  final String name;
  final List<ImageItem> images;

  const Folder(this.id, this.name, this.images);

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

  Map<String, dynamic> toJson() => _$FolderToJson(this);
}
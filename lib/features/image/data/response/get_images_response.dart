import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_images_response.g.dart';

@JsonSerializable()
class GetImagesResponse {
  final Folder folder;
  @JsonKey(name: 'files')
  final List<ImageItem> images;

  GetImagesResponse(this.folder, this.images);

  factory GetImagesResponse.fromJson(Map<String, dynamic> json) => _$GetImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetImagesResponseToJson(this);
}
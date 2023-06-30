import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_folders_response.g.dart';

@JsonSerializable()
class GetFoldersResponse {
  final List<Folder> folders;

  GetFoldersResponse(this.folders);

  factory GetFoldersResponse.fromJson(Map<String, dynamic> json) => _$GetFoldersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFoldersResponseToJson(this);
}
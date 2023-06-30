import 'package:json_annotation/json_annotation.dart';

part 'add_folder_request.g.dart';

@JsonSerializable()
class AddFolderRequest {
  final String token;
  @JsonKey(name: 'folderName')
  final String name;

  AddFolderRequest(this.token, this.name);

  factory AddFolderRequest.fromJson(Map<String, dynamic> json) => _$AddFolderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFolderRequestToJson(this);
}

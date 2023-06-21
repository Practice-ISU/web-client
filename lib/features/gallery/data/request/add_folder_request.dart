import 'package:json_annotation/json_annotation.dart';

part 'add_folder_request.g.dart';

@JsonSerializable()
class AddFolderRequest {
  final String accessToken;
  final String name;

  AddFolderRequest(this.accessToken, this.name);

  factory AddFolderRequest.fromJson(Map<String, dynamic> json) => _$AddFolderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFolderRequestToJson(this);
}

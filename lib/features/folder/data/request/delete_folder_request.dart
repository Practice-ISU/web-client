import 'package:json_annotation/json_annotation.dart';

part 'delete_folder_request.g.dart';

@JsonSerializable()
class DeleteFolderRequest {
  final String token;
  final int folderId;

  DeleteFolderRequest(this.token, this.folderId);

  factory DeleteFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteFolderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFolderRequestToJson(this);
}

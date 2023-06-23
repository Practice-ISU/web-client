import 'package:json_annotation/json_annotation.dart';

part 'get_images_request.g.dart';

@JsonSerializable()
class GetImagesRequest {
  final String accessToken;
  final int folderId;

  GetImagesRequest(this.accessToken, this.folderId);

  factory GetImagesRequest.fromJson(Map<String, dynamic> json) => _$GetImagesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetImagesRequestToJson(this);
}
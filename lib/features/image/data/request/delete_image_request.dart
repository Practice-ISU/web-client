import 'package:json_annotation/json_annotation.dart';

part 'delete_image_request.g.dart';

@JsonSerializable()
class DeleteImageRequest {
  final String token;
  final int id;

  DeleteImageRequest(this.token, this.id);

  factory DeleteImageRequest.fromJson(Map<String, dynamic> json) => _$DeleteImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteImageRequestToJson(this);
}
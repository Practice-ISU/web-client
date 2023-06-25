import 'package:json_annotation/json_annotation.dart';

part 'upload_image_request.g.dart';

@JsonSerializable()
class UploadImageRequest {
  final String token;
  final int folderId;
  final String original;
  final String painted;

  UploadImageRequest({
    required this.token,
    required this.folderId,
    required this.original,
    required this.painted,
  });

  factory UploadImageRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageRequestToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'upload_image_request.g.dart';

@JsonSerializable()
class UploadImageRequest {
  final String token;
  final int folderId;
  @JsonKey(name: 'base64')
  final String file;
  @JsonKey(name: 'format')
  final String format;
  final String fileName;

  UploadImageRequest({
    required this.token,
    required this.folderId,
    required this.file,
    required this.format,
    required this.fileName,
  });

  factory UploadImageRequest.fromJson(Map<String, dynamic> json) => _$UploadImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageRequestToJson(this);
}

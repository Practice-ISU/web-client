import 'package:json_annotation/json_annotation.dart';

part 'download_images_response.g.dart';

@JsonSerializable()
class DownloadImagesResponse {
  final String url;

  DownloadImagesResponse(this.url);

  factory DownloadImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$DownloadImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadImagesResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'access_token_request.g.dart';

@JsonSerializable()
class AccessTokenRequest {
  final String token;

  AccessTokenRequest(this.token);

  factory AccessTokenRequest.fromJson(Map<String, dynamic> json) => _$AccessTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenRequestToJson(this);
}
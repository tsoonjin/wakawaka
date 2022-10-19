import 'package:json_annotation/json_annotation.dart';

part 'game_socket_request.g.dart';

@JsonSerializable()
class GameSocketRequest {
  final String command;
  final dynamic payload;

  GameSocketRequest(this.command, this.payload);

  factory GameSocketRequest.fromJson(Map<String, dynamic> json) =>
      _$GameSocketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GameSocketRequestToJson(this);
}

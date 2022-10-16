import 'package:json_annotation/json_annotation.dart';

part 'game_socket_request.g.dart';

@JsonSerializable()
class GameSocketRequest {
  final String name;
  final int? roomId;

  GameSocketRequest(this.name, [this.roomId]);

  factory GameSocketRequest.fromJson(Map<String, dynamic> json) =>
      _$GameSocketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GameSocketRequestToJson(this);
}

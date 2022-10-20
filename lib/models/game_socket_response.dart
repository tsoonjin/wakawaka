import 'package:json_annotation/json_annotation.dart';

part 'game_socket_response.g.dart';

@JsonSerializable()
class GameSocketResponse {
  final String message;

  GameSocketResponse(this.message);

  factory GameSocketResponse.fromJson(Map<String, dynamic> json) =>
      _$GameSocketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GameSocketResponseToJson(this);
}

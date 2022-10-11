import 'package:json_annotation/json_annotation.dart';

part 'game_socket_response.g.dart';

@JsonSerializable()
class GameSocketResponse {
  final String gameState;
  final Map<String, int> scores;
  final Map<String, int> healths;
  final int roomId;
  final int timeLeft;

  GameSocketResponse(this.gameState, this.scores, this.healths, this.roomId, this.timeLeft);

  factory GameSocketResponse.fromJson(Map<String, dynamic> json) =>
      _$GameSocketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GameSocketResponseToJson(this);
}

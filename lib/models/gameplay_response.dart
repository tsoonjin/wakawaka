import 'package:json_annotation/json_annotation.dart';

part 'gameplay_response.g.dart';

@JsonSerializable()
class GamePlayResponse {
  final int timeLeft;
  final Map<String, int> score;
  final Map<String, int> health;
  final String state;
  final List<String> board;

  GamePlayResponse(this.timeLeft, this.score, this.health, this.state, this.board);

  factory GamePlayResponse.fromJson(Map<String, dynamic> json) =>
      _$GamePlayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GamePlayResponseToJson(this);
}

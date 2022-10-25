import 'package:json_annotation/json_annotation.dart';

part 'room_socket_response.g.dart';

@JsonSerializable()
class RoomSocketResponse {
  final String name;
  final bool isPrivate;
  final String state;
  final List<String> readyPlayers;
  final List<String> waitingPlayers;

  RoomSocketResponse(this.name, this.isPrivate, this.state, this.readyPlayers, this.waitingPlayers);

  factory RoomSocketResponse.fromJson(Map<String, dynamic> json) =>
      _$RoomSocketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomSocketResponseToJson(this);
}

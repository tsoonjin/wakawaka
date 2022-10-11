// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSocketResponse _$GameSocketResponseFromJson(Map<String, dynamic> json) =>
    GameSocketResponse(
      json['gameState'] as String,
      Map<String, int>.from(json['scores'] as Map),
      Map<String, int>.from(json['healths'] as Map),
      json['roomId'] as int,
      json['timeLeft'] as int,
    );

Map<String, dynamic> _$GameSocketResponseToJson(GameSocketResponse instance) =>
    <String, dynamic>{
      'gameState': instance.gameState,
      'scores': instance.scores,
      'healths': instance.healths,
      'roomId': instance.roomId,
      'timeLeft': instance.timeLeft,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameplay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamePlayResponse _$GamePlayResponseFromJson(Map<String, dynamic> json) =>
    GamePlayResponse(
      json['timeLeft'] as int,
      Map<String, int>.from(json['score'] as Map),
      Map<String, int>.from(json['health'] as Map),
      json['state'] as String,
      (json['board'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GamePlayResponseToJson(GamePlayResponse instance) =>
    <String, dynamic>{
      'timeLeft': instance.timeLeft,
      'score': instance.score,
      'health': instance.health,
      'state': instance.state,
      'board': instance.board,
    };

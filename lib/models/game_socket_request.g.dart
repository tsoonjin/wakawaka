// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_socket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSocketRequest _$GameSocketRequestFromJson(Map<String, dynamic> json) =>
    GameSocketRequest(
      json['command'] as String,
      json['payload'],
    );

Map<String, dynamic> _$GameSocketRequestToJson(GameSocketRequest instance) =>
    <String, dynamic>{
      'command': instance.command,
      'payload': instance.payload,
    };

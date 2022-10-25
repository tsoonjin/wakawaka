// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomSocketResponse _$RoomSocketResponseFromJson(Map<String, dynamic> json) =>
    RoomSocketResponse(
      json['name'] as String,
      json['isPrivate'] as bool,
      json['state'] as String,
      (json['readyPlayers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['waitingPlayers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RoomSocketResponseToJson(RoomSocketResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isPrivate': instance.isPrivate,
      'state': instance.state,
      'readyPlayers': instance.readyPlayers,
      'waitingPlayers': instance.waitingPlayers,
    };

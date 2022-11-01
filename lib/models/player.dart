import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Player {
    final String name;
    final int score;
    final int health;

    Player({
        required this.name,
        required this.score,
        required this.health
    });

    factory Player.fromJson(Map<String, dynamic> json) {
        return Player(name: json['name'], score: json['score'], health: json['health']);
    }
}

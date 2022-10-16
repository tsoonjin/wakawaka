import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Post {
    final int id;
    final String title;
    final String description;

    Post({
        required this.id,
        required this.title,
        required this.description
    });

    factory Post.fromJson(Map<String, dynamic> json) {
        return Post(id: json['id'], title: json['title'], description: json['body']);
    }
}

import 'package:meta/meta.dart';

@immutable
final class User {
  final String name;
  final String id; // TODO: probably should map to Firebase Authentication id.
  String password;

  User({required this.name, required this.id,required this.password});

  // add serialization methods here

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      password: json['testAttri']
    );
  }
}
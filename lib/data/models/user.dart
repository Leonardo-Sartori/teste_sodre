

import 'dart:convert';

class User {
  int id = 0;
  String name = "";
  String email = "";
  int age = 0;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  String toJson() => jsonEncode(toMap());

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: int.parse(map['age']),
    );
  }

  factory User.fromJson(String json){
    final jsonMap = jsonDecode(json);
    return User.fromMap(jsonMap);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age.toString(),
    };
  }

  @override
  String toString() {
    return name;
  }
}
import 'dart:math';

import 'package:flutter/cupertino.dart';

class User {
  String? id;
  String position;
  String? municipalityNumber;
  String? lastName;
  String? firstName;
  String? gender;
  String? party;
  String? startDate;
  String? endDate;
  String? memberStatus;
  String? memberPhoto;
  String? password;

  User({
    required this.password,
    required this.endDate,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.memberPhoto,
    required this.memberStatus,
    required this.municipalityNumber,
    required this.party,
    required this.position,
    required this.startDate,
    required this.id,
  });
  static List<User> generateRandomUsers(int count) {
    final Random random = Random();
    final List<User> users = [];
    final positions = ['Administrador', 'Presidente', 'Secretario', 'Regidor'];

    for (int i = 0; i < count; i++) {
      final position = positions[random.nextInt(positions.length)];
      final password = (random.nextInt(8999) + 1000).toString();
      if (password == '1209') continue;

      users.add(User(
        position: position,
        password: password,
        endDate: '2040-01-01T00:00:00Z',
        firstName: 'FirstName$i',
        gender: 'Masculino',
        lastName: 'LastName$i',
        memberPhoto: 'photo$i',
        memberStatus: 'Activo',
        municipalityNumber: '0',
        party: 'sin-definir',
        startDate: '2023-07-18T00:00:00Z',
        id: "error",
      ));
    }

    return users;
  }

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      position: user['position'],
      password: user['password'],
      endDate: user['endDate'],
      lastName: user['lastName'],
      firstName: user['firstName'],
      gender: user['gender'],
      memberPhoto: user['memberPhoto'],
      memberStatus: user['memberStatus'],
      municipalityNumber: user['municipalityNumber'],
      party: user['party'],
      startDate: user['startDate'],
      id: user['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'position': position,
      'municipalityNumber': municipalityNumber,
      'lastName': lastName,
      'firstName': firstName,
      'gender': gender,
      'party': party,
      'startDate': startDate,
      'endDate': endDate,
      'memberStatus': memberStatus,
      'memberPhoto': memberPhoto,
      'password': password,
      '_id': id,
    };
    debugPrint("$json");
    return json;
  }
}

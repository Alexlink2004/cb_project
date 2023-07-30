// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['position'],
  );
  return User(
    position: json['position'] as String,
    municipalityNumber: json['municipalityNumber'] as int,
    last_name: json['last_name'] as String,
    middle_name: json['middle_name'] as String,
    first_name: json['first_name'] as String,
    gender: json['gender'] as String,
    party: json['party'] as String,
    start_date: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    end_date: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
    member_status: json['member_status'] as String,
    member_photo: json['member_photo'] as String?,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'position': instance.position,
      'municipalityNumber': instance.municipalityNumber,
      'last_name': instance.last_name,
      'middle_name': instance.middle_name,
      'first_name': instance.first_name,
      'gender': instance.gender,
      'party': instance.party,
      'start_date': instance.start_date?.toIso8601String(),
      'end_date': instance.end_date?.toIso8601String(),
      'member_status': instance.member_status,
      'member_photo': instance.member_photo,
      'password': instance.password,
    };

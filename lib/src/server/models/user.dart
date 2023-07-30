import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: true)
  String position;

  @JsonKey()
  int municipalityNumber;

  @JsonKey()
  String last_name;

  @JsonKey()
  String middle_name;

  @JsonKey()
  String first_name;

  @JsonKey()
  String gender;

  @JsonKey()
  String party;

  @JsonKey()
  DateTime? start_date;

  @JsonKey()
  DateTime? end_date;

  @JsonKey()
  String member_status;

  @JsonKey()
  String? member_photo;

  @JsonKey()
  String password;

  User({
    required this.position,
    required this.municipalityNumber,
    required this.last_name,
    required this.middle_name,
     required this.first_name,
    required this.gender,
    required this.party,
    required this.start_date,
    this.end_date,
    required this.member_status,
    this.member_photo,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

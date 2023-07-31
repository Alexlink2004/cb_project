import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: true)
  String? position;

  @JsonKey()
  int? municipalityNumber;

  @JsonKey()
  String? last_name;


  @JsonKey()
  String? first_name;

  @JsonKey()
  String? gender;

  @JsonKey()
  String? party;

  @JsonKey()
  DateTime? start_date;

  @JsonKey()
  DateTime? end_date;

  @JsonKey()
  String? member_status;

  @JsonKey()
  Map<String, dynamic>? member_photo; // Cambio de List<int>? a Map<String, dynamic>?

  @JsonKey()
  String? password;

  User({
    this.position,
    this.municipalityNumber,
    this.last_name,

    this.first_name,
    this.gender,
    this.party,
    this.start_date,
    this.end_date,
    this.member_status,
    this.member_photo,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

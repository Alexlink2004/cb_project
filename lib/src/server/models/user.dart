class User {
  String? position;
  int? municipalityNumber;
  String? lastName;
  String? firstName;
  String? gender;
  String? party;
  DateTime? startDate;
  DateTime? endDate;
  String? memberStatus;
  Map<String, dynamic>? memberPhoto;
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
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      password: user['password'],
      endDate: user['endDate'],
      firstName: user['firstName'],
      gender: user['gender'],
      lastName: user['lastName'],
      memberPhoto: user['memberPhoto'],
      memberStatus: user['memberStatus'],
      municipalityNumber: user['municipalityNumber'],
      party: user['party'],
      position: user['position'],
      startDate: user['startDate'],
    );
  }
}

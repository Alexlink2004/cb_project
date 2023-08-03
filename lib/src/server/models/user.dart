class User {
  String position;
  int? municipalityNumber;
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
  });

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
    );
  }
}

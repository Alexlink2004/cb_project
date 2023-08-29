import 'package:cb_project/src/server/models/user.dart';
import 'package:cb_project/src/server/models/voting_point.dart';

class VotingSession {
  String municipalityNumber;
  String location;
  List<User> justifiedAbsences;
  List<VotingPoint> votingPoints;

  VotingSession({
    required this.municipalityNumber,
    required this.location,
    required this.justifiedAbsences,
    required this.votingPoints,
  });

  factory VotingSession.fromJson(Map<String, dynamic> json) {
    return VotingSession(
      municipalityNumber: json['municipalityNumber'],
      location: json['location'],
      justifiedAbsences: List<User>.from(
          json['justifiedAbsences'].map((x) => User.fromJson(x))),
      votingPoints: List<VotingPoint>.from(
          json['votingPoints'].map((x) => VotingPoint.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'municipalityNumber': municipalityNumber,
      'location': location,
      'justifiedAbsences':
          List<dynamic>.from(justifiedAbsences.map((x) => x.toJson())),
      'votingPoints': List<dynamic>.from(votingPoints.map((x) => x.toJson())),
    };
  }
}

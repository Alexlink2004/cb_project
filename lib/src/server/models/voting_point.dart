import 'user.dart';

class VotingPoint {
  String commision;
  String requiredVotes;
  String votingForm;
  String subject;
  List<User> votesFor;
  List<User> votesAgainst;
  List<User> votesAbstain;

  VotingPoint({
    required this.commision,
    required this.requiredVotes,
    required this.votingForm,
    required this.subject,
    required this.votesFor,
    required this.votesAgainst,
    required this.votesAbstain,
  });

  factory VotingPoint.fromJson(Map<String, dynamic> json) {
    return VotingPoint(
      commision: json['commision'],
      requiredVotes: json['required_votes'],
      votingForm: json['voting_form'],
      subject: json['subject'],
      votesFor:
          (json['votesFor'] as List).map((i) => User.fromJson(i)).toList(),
      votesAgainst:
          (json['votesAgainst'] as List).map((i) => User.fromJson(i)).toList(),
      votesAbstain:
          (json['votesAbstain'] as List).map((i) => User.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commision': commision,
      'required_votes': requiredVotes,
      'voting_form': votingForm,
      'subject': subject,
      'votesFor': votesFor.map((i) => i.toJson()).toList(),
      'votesAgainst': votesAgainst.map((i) => i.toJson()).toList(),
      'votesAbstain': votesAbstain.map((i) => i.toJson()).toList(),
    };
  }
}

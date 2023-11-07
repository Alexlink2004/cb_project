import 'user.dart';

class VotingPoint {
  String commision;
  String requiredVotes;
  String votingForm;
  String subject;
  String description;
  List<User> votesFor;
  List<User> votesAgainst;
  List<User> votesAbstain;
  String id;

  VotingPoint({
    required this.commision,
    required this.requiredVotes,
    required this.votingForm,
    required this.subject,
    required this.votesFor,
    required this.votesAgainst,
    required this.votesAbstain,
    required this.description,
    required this.id,
  });

  factory VotingPoint.fromJson(Map<String, dynamic> json) {
    return VotingPoint(
      id: json['_id'],
      description: json['description'],
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
      '_id': id,
      'description': description,
      'commision': commision,
      'required_votes': requiredVotes,
      'voting_form': votingForm,
      'subject': subject,
      'votesFor': [],
      'votesAgainst': [],
      'votesAbstain': [],
    };
  }
}

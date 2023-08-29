import 'package:cb_project/src/server/models/user.dart';
import 'package:flutter/material.dart';

import '../models/voting_point.dart';

class VotingSessionSocket extends ChangeNotifier {
  List<VotingPoint> votingPoints = [];
  int currentIndex = 0;

  void updateData(List<VotingPoint> newVotingPoints, int newCurrentIndex) {
    votingPoints = newVotingPoints;
    currentIndex = newCurrentIndex;
    notifyListeners();
  }

  void nextPoint() {
    //  currentIndex++;
    notifyListeners();
  }

  void previousPoint() {
    // currentIndex--;
    notifyListeners();
  }

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void vote(User user, String voteType) {
    final point = votingPoints[currentIndex];
    if (voteType == 'for') {
      point.votesFor.add(user);
    } else if (voteType == 'against') {
      point.votesAgainst.add(user);
    } else if (voteType == 'abstain') {
      point.votesAbstain.add(user);
    }
    notifyListeners();
  }
}

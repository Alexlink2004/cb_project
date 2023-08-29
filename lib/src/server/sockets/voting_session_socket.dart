import 'dart:convert';

import 'package:cb_project/src/server/api/api_constants.dart';
import 'package:cb_project/src/server/models/user.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/voting_point.dart';

class VotingSessionSocket extends ChangeNotifier {
  late IO.Socket socket;
  List<VotingPoint> votingPoints = [];
  int currentIndex = 0;

  VotingSessionSocket() {
    socket = IO.io(ApiConstants.apiRoute, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('Connected');
    });

    socket.on('server:update_session', (data) {
      final List<dynamic> points = jsonDecode(data['votingPoints']);
      votingPoints = points.map((e) => VotingPoint.fromJson(e)).toList();
      currentIndex = data['currentIndex'];
      notifyListeners();
    });

    socket.connect();
  }

  void nextPoint() {
    if (currentIndex < votingPoints.length - 1) {
      currentIndex++;
      socket.emit('client:nextpoint', {});
      notifyListeners();
    }
  }

  void previousPoint() {
    if (currentIndex > 0) {
      currentIndex--;
      socket.emit('client:previouspoint', {});
      notifyListeners();
    }
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
    socket.emit('client:vote', {'voteType': voteType, 'user': user.toJson()});
    notifyListeners();
  }

  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}

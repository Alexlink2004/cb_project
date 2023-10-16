import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../server/api/voting_point_api.dart';
import 'package:cb_project/src/server/models/voting_point.dart';

class VotingPointController extends ChangeNotifier {
  final VotingPointApi _api = VotingPointApi();

  List<VotingPoint> _votingPoints = [];

  List<VotingPoint> get votingPoints {
    _fetchVotingPoints();
    return _votingPoints;
  }

  Future<List<VotingPoint>> _fetchVotingPoints() async {
    _votingPoints = await _api.read();
    // debugPrint("Voting points from fetchVotingPoints() $_votingPoints");
    notifyListeners();
    return _votingPoints!;
  }

  Future<Response> createVotingPoint(VotingPoint votingPoint) async {
    final response = await _api.create(votingPoint);
    // After creating a new voting point, fetch the updated list
    await _fetchVotingPoints();
    return response;
  }

  Future<Response> deleteVotingPoint(String id) async {
    final response = await _api.delete(id);
    // After deleting a voting point, fetch the updated list
    await _fetchVotingPoints();
    return response;
  }

  void updateVotingPoint(String id, VotingPoint votingPoint) async {
    _api.update(id, votingPoint);
    // After updating a voting point, fetch the updated list
    await _fetchVotingPoints();
  }
}

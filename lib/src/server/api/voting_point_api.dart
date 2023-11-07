import 'package:cb_project/src/server/models/voting_point.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_constants.dart';

class VotingPointApi extends ChangeNotifier {
  final dio = Dio();

  List<VotingPoint> _votingPoints = [];

  bool validateVotingPoint(VotingPoint votingPoint) {
    if (votingPoint.commision.isEmpty ||
        votingPoint.requiredVotes.isEmpty ||
        votingPoint.votingForm.isEmpty ||
        votingPoint.subject.isEmpty ||
        votingPoint.description.isEmpty) {
      return false;
    }
    return true;
  }

  // Create VotingPoint
  Future<Response> create(VotingPoint votingPoint) async {
    if (!validateVotingPoint(votingPoint)) {
      debugPrint('Failed to create voting point: Invalid fields');
      notifyListeners();
    }

    final response = await dio.post(
      '${ApiConstants.apiRoute}/voting-session/voting-points',
      data: votingPoint.toJson(),
    );

    try {
      read();
      if (response.statusCode == 201) {
        debugPrint('Voting point created successfully');
        notifyListeners();
        return response;
      } else {
        debugPrint('Failed to create voting point: ${response.statusCode}');
        notifyListeners();
        return response;
      }
    } catch (e) {
      debugPrint('Error while creating voting point: $e');
      notifyListeners();
      return response;
    }
  }

  Future<List<VotingPoint>> read() async {
    // if (_votingPoints.isEmpty) {
    //
    // }
    final response =
        await dio.get("${ApiConstants.apiRoute}/voting-session/voting-points");
    final List<dynamic> responseData = response.data;
    _votingPoints =
        responseData.map((json) => VotingPoint.fromJson(json)).toList();
    return _votingPoints;
  }

  // Update VotingPoint
  void update(String id, VotingPoint votingPoint) async {
    try {
      final response = await dio.put(
        '${ApiConstants.apiRoute}/voting-session/voting-points/$id',
        data: votingPoint.toJson(),
      );
    } catch (e) {}
  }

  // Delete VotingPoint

  Future<Response> delete(String id) async {
    final response = await dio.delete(
      '${ApiConstants.apiRoute}/voting-session/voting-points/$id',
    );
    read();
    return response;
  }
}

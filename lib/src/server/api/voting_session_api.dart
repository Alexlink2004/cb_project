import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/voting_session.dart';
import 'api_constants.dart';

class VotingSessionApi extends ChangeNotifier {
  final dio = Dio();

  // Create a new voting session
  Future<Response> create(VotingSession session) async {
    final response = await dio.post(
      '${ApiConstants.apiRoute}/voting_session',
      data: session.toJson(),
    );
    if (response.statusCode == 201) {
      print('Voting session created successfully');
      notifyListeners();
      return response;
    } else {
      print('Failed to create voting session: ${response.statusCode}');
      return response;
    }
  }

  // Get the current voting session
  Future<VotingSession> read() async {
    final response =
        await dio.get('${ApiConstants.apiRoute}/voting_session/get_session');
    if (response.statusCode == 200) {
      return VotingSession.fromJson(response.data);
    } else {
      debugPrint('Failed to get voting session: ${response.statusCode}');
      return ApiConstants.vottingSessionError; // Replace with your error object
    }
  }

  // Update the entire voting session
  Future<Response> update(VotingSession session) async {
    final response = await dio.put(
      '${ApiConstants.apiRoute}/voting_session/update_session',
      data: session.toJson(),
    );
    if (response.statusCode == 200) {
      print('Voting session updated successfully');
      notifyListeners();
      return response;
    } else {
      print('Failed to update voting session: ${response.statusCode}');
      return response;
    }
  }

  // // Add a voting point to the current session
  // Future<Response> addVotingPoint(VotingPoint point) async {
  //   // Implement your logic here
  // }
  //
  // // Delete a specific voting point from the current session
  // Future<Response> deleteVotingPoint(String id) async {
  //   // Implement your logic here
  // }
  //
  // // Add a justified absence to the current session
  // Future<Response> addJustifiedAbsence(String userId) async {
  //   // Implement your logic here
  // }
  //
  // // Delete a justified absence from the current session
  // Future<Response> deleteJustifiedAbsence(String userId) async {
  //   // Implement your logic here
  // }
}

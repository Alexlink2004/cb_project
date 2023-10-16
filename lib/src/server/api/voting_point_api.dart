import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cb_project/src/server/models/voting_point.dart';
import 'package:flutter/material.dart';
import 'api_constants.dart';

class VotingPointApi extends ChangeNotifier {
  final dio = Dio();

  List<VotingPoint> _votingPoints = [];

  // Create VotingPoint
  Future<Response> create(VotingPoint votingPoint) async {
    final response = await dio.post(
      '${ApiConstants.apiRoute}/voting-session/voting-points',
      data: votingPoint.toJson(),
    );
    // Handle response...
    return response;
  }

  // // Read all VotingPoints
  // Future<List<VotingPoint>> read() async {
  //   Response response =
  //       await dio.get("${ApiConstants.apiRoute}/voting-session/voting-points");

  //   final List<dynamic> responseData = response.data;

  //   final List<VotingPoint> votingPoints =
  //       responseData.map((json) => VotingPoint.fromJson(json)).toList();

  //   // debugPrint("Inicio de impresion de datos");
  //   // for (VotingPoint point in votingPoints) {
  //   //   debugPrint("Datos de punto:");
  //   //   debugPrint(point.subject);
  //   //   debugPrint(point.description);
  //   // }
  //   // debugPrint("Final de impresion de datos");
  //   notifyListeners();
  //   return votingPoints;
  // }
  Future<List<VotingPoint>> read() async {
    if (_votingPoints.isEmpty) {
      final response = await dio
          .get("${ApiConstants.apiRoute}/voting-session/voting-points");
      final List<dynamic> responseData = response.data;
      _votingPoints =
          responseData.map((json) => VotingPoint.fromJson(json)).toList();
    }
    return _votingPoints;
  }

  // Update VotingPoint
  void update(String id, VotingPoint votingPoint) async {
    try {
      final response = await dio.put(
        '${ApiConstants.apiRoute}/voting-session/voting-points/$id',
        data: votingPoint.toJson(),
      );
      // Handle response...
    } catch (e) {
      // Handle error...
    }
  }

  // Delete VotingPoint

  Future<Response> delete(String id) async {
    final response = await dio.delete(
      '${ApiConstants.apiRoute}/voting-session/voting-points/$id',
    );
    return response;
  }
}

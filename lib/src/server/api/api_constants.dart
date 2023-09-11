import 'package:cb_project/src/server/models/voting_session.dart';

import '../models/user.dart';

class ApiConstants {
  static const apiRoute = "http://localhost:3001";
  //static const apiRoute = "http://192.168.1.253:3001";
  static User errorUser = User(
    password: 'error',
    endDate: 'error',
    firstName: 'error',
    gender: 'error',
    lastName: 'error',
    memberPhoto: 'error',
    memberStatus: 'error',
    municipalityNumber: 'error',
    party: 'error',
    position: 'error',
    startDate: 'error',
    id: 'error',
  );
  static VotingSession votingSessionError = VotingSession(
    municipalityNumber: 'error',
    location: 'error',
    justifiedAbsences: [],
    votingPoints: [],
  );
}

class Permission {
  final bool canAdvanceSession;
  final bool canRegressSession;
  final bool canStartSession;
  final bool canGiveVoice;
  final bool canStartVoting;
  final bool canViewVotingResult;
  final bool canCallRecess;
  final bool canEndSession;
  final bool canRequestWord;
  final bool canGiveVote;
  final bool canViewRegidorVotingResult;
  final bool canViewAttendeesList;
  final bool canRemoveFromSession;
  final bool canViewOratorsList;

  Permission({
    required this.canAdvanceSession,
    required this.canRegressSession,
    required this.canStartSession,
    required this.canGiveVoice,
    required this.canStartVoting,
    required this.canViewVotingResult,
    required this.canCallRecess,
    required this.canEndSession,
    required this.canRequestWord,
    required this.canGiveVote,
    required this.canViewRegidorVotingResult,
    required this.canViewAttendeesList,
    required this.canRemoveFromSession,
    required this.canViewOratorsList,
  });

  // Constructor para asignar permisos predeterminados a roles específicos.
  factory Permission.forRole(String role) {
    switch (role.toLowerCase()) {
      case 'regidor':
        return Permission(
          canAdvanceSession: false,
          canRegressSession: false,
          canStartSession: false,
          canGiveVoice: true,
          canStartVoting: true,
          canViewVotingResult: true,
          canCallRecess: false,
          canEndSession: false,
          canRequestWord: true,
          canGiveVote: true,
          canViewRegidorVotingResult: true,
          canViewAttendeesList: false,
          canRemoveFromSession: false,
          canViewOratorsList: false,
        );
      case 'presidente':
        return Permission(
          canAdvanceSession: true,
          canRegressSession: true,
          canStartSession: true,
          canGiveVoice: true,
          canStartVoting: true,
          canViewVotingResult: true,
          canCallRecess: true,
          canEndSession: true,
          canRequestWord: true,
          canGiveVote: true,
          canViewRegidorVotingResult: true,
          canViewAttendeesList: true,
          canRemoveFromSession: false,
          canViewOratorsList: true,
        );
      case 'secretario':
        return Permission(
          canAdvanceSession: false,
          canRegressSession: false,
          canStartSession: false,
          canGiveVoice: false,
          canStartVoting: false,
          canViewVotingResult: false,
          canCallRecess: false,
          canEndSession: false,
          canRequestWord: false,
          canGiveVote: false,
          canViewRegidorVotingResult: true,
          canViewAttendeesList: true,
          canRemoveFromSession: true,
          canViewOratorsList: true,
        );
      default:
        // Si el rol no coincide con ninguno de los anteriores, asignamos todos los permisos a false.
        return Permission(
          canAdvanceSession: false,
          canRegressSession: false,
          canStartSession: false,
          canGiveVoice: false,
          canStartVoting: false,
          canViewVotingResult: false,
          canCallRecess: false,
          canEndSession: false,
          canRequestWord: false,
          canGiveVote: false,
          canViewRegidorVotingResult: false,
          canViewAttendeesList: false,
          canRemoveFromSession: false,
          canViewOratorsList: false,
        );
    }
  }
}

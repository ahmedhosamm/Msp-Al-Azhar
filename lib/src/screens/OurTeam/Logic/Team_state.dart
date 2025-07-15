abstract class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final List<dynamic> teamMembers;
  TeamLoaded(this.teamMembers);
}

class TeamError extends TeamState {
  final String message;
  TeamError(this.message);
}

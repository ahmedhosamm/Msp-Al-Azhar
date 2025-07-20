import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Team.dart';
import 'Team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamInitial());

  Future<void> fetchTeamMembers() async {
    emit(TeamLoading());
    try {
      final members = await TeamApi.fetchTeamMembers();
      final shuffledMembers = members.toList()..shuffle();
      emit(TeamLoaded(shuffledMembers));
    } catch (e) {
      emit(TeamError(e.toString()));
    }
  }
}

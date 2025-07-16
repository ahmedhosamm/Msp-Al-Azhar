import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_details_state.dart';
import 'package:dio/dio.dart';

class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit() : super(ProfileDetailsLoading());

  Future<void> fetchMember(String memberId) async {
    emit(ProfileDetailsLoading());
    try {
      final dio = Dio();
      final response = await dio.get('https://api.msp-alazhar.tech/teamMembersClient/get');
      if (response.statusCode == 200 && response.data != null) {
        final results = response.data['results'] as List<dynamic>;
        final found = results.firstWhere((e) => e['_id'] == memberId, orElse: () => null);
        if (found != null) {
          emit(ProfileDetailsLoaded(found));
        } else {
          emit(ProfileDetailsError('Member not found'));
        }
      } else {
        emit(ProfileDetailsError('Failed to load data'));
      }
    } catch (e) {
      emit(ProfileDetailsError('Error: $e'));
    }
  }
} 
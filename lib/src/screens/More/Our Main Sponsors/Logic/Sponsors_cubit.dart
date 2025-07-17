import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Sponsors.dart';
import 'Sponsors_state.dart';

class SponsorsCubit extends Cubit<SponsorsState> {
  final SponsorsRepository repository;
  SponsorsCubit(this.repository) : super(SponsorsInitial());

  Future<void> fetchSponsors() async {
    emit(SponsorsLoading());
    try {
      final sponsors = await repository.fetchSponsors();
      emit(SponsorsSuccess(sponsors));
    } catch (e) {
      emit(SponsorsFailure(e.toString()));
    }
  }
}

abstract class SponsorsState {}

class SponsorsInitial extends SponsorsState {}

class SponsorsLoading extends SponsorsState {}

class SponsorsSuccess extends SponsorsState {
  final List<dynamic> sponsors;
  SponsorsSuccess(this.sponsors);
}

class SponsorsFailure extends SponsorsState {
  final String error;
  SponsorsFailure(this.error);
}

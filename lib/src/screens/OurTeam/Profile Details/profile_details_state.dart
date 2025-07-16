abstract class ProfileDetailsState {}

class ProfileDetailsLoading extends ProfileDetailsState {}

class ProfileDetailsLoaded extends ProfileDetailsState {
  final Map<String, dynamic> member;
  ProfileDetailsLoaded(this.member);
}

class ProfileDetailsError extends ProfileDetailsState {
  final String message;
  ProfileDetailsError(this.message);
} 
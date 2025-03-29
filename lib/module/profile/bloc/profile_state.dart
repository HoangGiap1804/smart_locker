abstract class ProfileState {}

class ProfileInital extends ProfileState{}
class ProfileLoading extends ProfileState{}
class SubmissionSuccess extends ProfileState{}
class SubmissionFaild extends ProfileState{
  final String error;
  SubmissionFaild({
    required this.error,
  });
}

import 'package:smart_locker/module/profile/bloc/profile_event.dart';
import 'package:smart_locker/module/profile/bloc/profile_state.dart';
import 'package:smart_locker/module/profile/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc() : super(ProfileInital())  {
    on<UpdateInfo>((event, emit) async{
      emit(ProfileLoading());

      String res = await ProfileRepository().UpdateInfo(event.profileModel);
      if(res == "success"){
        emit(SubmissionSuccess());
      }
      else{
        emit(SubmissionFaild(error: res));
      }
    });
  }
}

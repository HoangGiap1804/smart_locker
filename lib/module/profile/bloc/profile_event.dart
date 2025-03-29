import 'package:smart_locker/module/profile/models/profile_model.dart';

abstract class ProfileEvent {}

class UpdateInfo extends ProfileEvent{
  ProfileModel profileModel;

  UpdateInfo({
   required this.profileModel,
  });

} 

import 'package:cctv_tun/page/profile/profile_reducer.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileAction {
  final ProfileState appState;

  ProfileAction(this.appState);
}

//action
updateProfileAction(Map<String, dynamic> newapp) {
  //logic for change state

  return ProfileAction(ProfileState(profile: newapp));
}

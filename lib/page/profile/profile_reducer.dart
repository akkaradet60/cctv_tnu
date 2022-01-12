import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState({this.profile = const {'user_email': 'No Data'}});

  ProfileState copyWith({required Map<String, dynamic> profile}) {
    return ProfileState(profile: profile);
  }
}

//reducer
profileReducer(ProfileState state, dynamic action) {
  if (action is ProfileAction) {
    return state.copyWith(profile: action.profileState.profile);
  }
  return state;
}

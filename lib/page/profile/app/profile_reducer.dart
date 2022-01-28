import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> app;

  ProfileState({this.app = const {'user_email': 'No Data'}});

  ProfileState copyWith({required Map<String, void> app}) {
    return ProfileState(app: app);
  }
}

//reducer
profileReducer(ProfileState state, dynamic action) {
  if (action is ProfileAction) {
    return state.copyWith(app: action.profileState.profile);
  }
  return state;
}

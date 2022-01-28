import 'package:cctv_tun/page/profile/profile_reducer.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ProfileState appState;

  AppState({required this.appState});

  factory AppState.initial() {
    return AppState(appState: ProfileState());
  }
}

//reducer
AppState appReducer(AppState state, dynamic action) {
  return AppState(appState: profileReducer(state.appState, action));
}

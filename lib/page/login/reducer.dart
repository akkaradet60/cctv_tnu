import 'package:cctv_tun/page/login/action.dart';
import 'package:meta/meta.dart';

@immutable
class ApplicationState {
  final Map<String, dynamic> application;

  const ApplicationState({this.application = const {'app_id': '0'}});

  ApplicationState copyWith({required Map<String, dynamic> application}) {
    return ApplicationState(application: application);
  }
}

//reducer
ApplicationState applicationReducer(ApplicationState state, dynamic action) {
  if (action is ApplicationAction) {
    return state.copyWith(application: action.applicationState.application);
  }
  return state;
}

import 'package:cctv_tun/page/login/reducer.dart';
import 'package:meta/meta.dart';

@immutable
class ApplicationAction {
  final ApplicationState applicationState;

  const ApplicationAction(this.applicationState);
}

//action
updateApplicationAction(Map<String, dynamic> newApplication) {
  //logic for change state

  return ApplicationAction(ApplicationState(application: newApplication));
}

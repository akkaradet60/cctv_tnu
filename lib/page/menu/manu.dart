import 'dart:convert';

import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menu_pang extends StatefulWidget {
  menu_pang({Key? key}) : super(key: key);

  @override
  _menu_pangState createState() => _menu_pangState();
}

class _menu_pangState extends State<menu_pang> {
  var newProfile;
  var profile;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newProfile = json.decode(prefs.getString('profile').toString());
    //call redux action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    //กลับไปที่หน้า Login
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      decoration: BoxDecoration(
          color: ThemeBc.background,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(2, 4),
                blurRadius: 7.0,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          backgroundColor: ThemeBc.background,
          child: Container(
            child: ListView(
              children: [
                Expanded(
                    flex: isPortrait ? 1 : 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(2, 2),
                                  blurRadius: 7,
                                  spreadRadius: 1.0),
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2, 4),
                                  blurRadius: 7.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child:
                                StoreConnector<AppState, Map<String, dynamic>>(
                              distinct: true,
                              converter: (store) =>
                                  store.state.profileState.profile,
                              builder: (context, profile) {
                                return Container(
                                  child: UserAccountsDrawerHeader(
                                    currentAccountPicture: CircleAvatar(
                                      foregroundColor: ThemeBc.background,
                                      backgroundImage:
                                          AssetImage('assets/logo.png'),
                                      backgroundColor: ThemeBc.background,
                                    ),
                                    accountEmail: Text(
                                        'สวัสดีคุณ ${profile['user_firstname']}'),
                                    accountName: Text(
                                        'Email: ${profile['user_email']} '),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )),
                //theproduct

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    height: 50,
                    child: ListTile(
                      leading: Icon(Icons.stairs),
                      title: Text('หน้าหลัก'),
                      trailing: Icon(Icons.double_arrow),
                      selected:
                          ModalRoute.of(context)?.settings.name == '/home_page'
                              ? true
                              : false,
                      //  iconColor: Colors.orange,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                '/home_page', (route) => false);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    height: 50,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('ตั้งค่า'),
                      trailing: Icon(Icons.double_arrow),
                      selected:
                          ModalRoute.of(context)?.settings.name == '/settings'
                              ? true
                              : false,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                '/settings', (route) => false);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    height: 50,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('ออกจากระบบ'),
                      trailing: Icon(Icons.double_arrow),
                      onTap: () {
                        logout();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

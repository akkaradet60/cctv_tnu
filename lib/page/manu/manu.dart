import 'dart:convert';

import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class manu extends StatefulWidget {
  manu({Key? key}) : super(key: key);

  @override
  _manuState createState() => _manuState();
}

class _manuState extends State<manu> {
  var newProfile;
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
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: ListView(
          children: [
            Expanded(
                flex: isPortrait ? 1 : 3,
                child: Center(
                  child: StoreConnector<AppState, Map<String, dynamic>>(
                    distinct: true,
                    converter: (store) => store.state.profileState.profile,
                    builder: (context, profile) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserAccountsDrawerHeader(
                            currentAccountPicture: CircleAvatar(
                              backgroundImage: AssetImage('assets/logo.png'),
                              backgroundColor: Colors.pink,
                            ),
                            accountEmail: Text('สวัสดีคุณ ${profile['name']}'),
                            accountName: Text('Email: ${profile['email']} '),
                          ),
                        ],
                      );
                    },
                  ),
                )),
            //theproduct
            ListTile(
              leading: Icon(Icons.stairs),
              title: Text('หน้าหลัก'),
              trailing: Icon(Icons.double_arrow),
              selected: ModalRoute.of(context)?.settings.name == '/home_page'
                  ? true
                  : false,
              iconColor: Colors.orange,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil('/home_page', (route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('ตั้งค่า'),
              trailing: Icon(Icons.double_arrow),
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil('/SplashPage', (route) => false);
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('ออกจากระบบ'),
              trailing: Icon(Icons.double_arrow),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class manu extends StatefulWidget {
  manu({Key? key}) : super(key: key);

  @override
  _manuState createState() => _manuState();
}

class _manuState extends State<manu> {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('roke');
    await prefs.remove('profile');

    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/homepage/icon_1.png'),
                backgroundColor: Colors.pink,
              ),
              accountEmail: Text('email'),
              accountName: Text('akaka'),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('ร้านค่า'),
              trailing: Icon(Icons.double_arrow),
              selected: false,
              onTap: () => Navigator.pushNamed(context, '/productt'),
            ), //theproduct
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

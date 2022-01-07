import 'package:flutter/material.dart';

class menu extends StatefulWidget {
  menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/homepage/icon_1.png'),
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
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/SplashPage', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

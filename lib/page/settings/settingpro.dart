import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';

class settingpro extends StatefulWidget {
  settingpro({Key? key}) : super(key: key);

  @override
  _warn1State createState() => _warn1State();
}

class _warn1State extends State<settingpro> {
  @override
  Widget build(BuildContext context) {
    Widget im1() {
      return Container();
    }

    Widget icon() {
      return Column(
        children: [
          Container(
            child: Icon(
              Icons.account_circle,
              size: 150,
            ),
            width: 150,
            height: 250,
          )
        ],
      );
    }

    Widget title() {
      return SafeArea(
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: 150,
            margin: EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: [
                Text(
                  'หน้าจัดการสินค้า',
                  style: primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'สินค้าของร้านค้า',
                  style: primaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: IconButton(
                    color: Colors.green,
                    icon: Icon(
                      Icons.add_circle,
                      size: 60,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/settingprodot'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(child: const Text('จัดการสินค้า')),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              icon(),
              title(),
            ],
          ),
        ),
      ),
    );
  }
}

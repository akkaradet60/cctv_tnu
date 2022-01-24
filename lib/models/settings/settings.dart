import 'package:cctv_tun/page/manu/manu.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageSplash() {
      return Container(
        height: 225,
        width: 10,
        margin: EdgeInsets.only(top: 20),
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 18),
              Text(
                'ข้อมูล',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Column(
                  children: [
                    SignInButtonBuilder(
                      height: 45,
                      width: 300,
                      text: 'ร้านค้า',
                      icon: Icons.shopping_basket,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settingshop'),
                      backgroundColor: Colors.blueGrey[700]!,
                    ),
                    SignInButtonBuilder(
                      height: 45,
                      width: 300,
                      text: 'แก้ไขข้อมูลส่วนตัว',
                      icon: Icons.account_box,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settingprofile'),
                      backgroundColor: Colors.blueGrey[700]!,
                    ),
                    SignInButtonBuilder(
                      height: 45,
                      width: 300,
                      text: 'ข้อตกลงและเงื่อนไข',
                      icon: Icons.view_headline,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settingprofile'),
                      backgroundColor: Colors.blueGrey[700]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget text2() {
      return Container(
        height: 175,
        margin: EdgeInsets.only(top: 15),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 18),
              Text(
                'ตั้งค่า',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              SignInButtonBuilder(
                height: 45,
                width: 300,
                text: 'เปลี่ยนภาษา',
                icon: Icons.spellcheck,
                onPressed: () {},
                backgroundColor: Colors.blueGrey[700]!,
              ),
              SignInButtonBuilder(
                height: 45,
                width: 300,
                text: 'แก้ไขรหัสผ่าน',
                icon: Icons.vpn_key,
                onPressed: () {},
                backgroundColor: Colors.blueGrey[700]!,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: manu(),
      appBar: AppBar(
        title: Center(child: const Text('ตั้งค่า')),
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
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              imageSplash(),
              text2(),
            ],
          ),
        ),
      ),
    );
  }
}

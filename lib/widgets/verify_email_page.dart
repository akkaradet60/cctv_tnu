import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
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
    bool _secureText = true;
    Widget imageSplash() {
      return Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.network('https://www.mindphp.com/images/mail.png')],
        ),
      );
    }

    Widget button() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 0, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                  label: const Text('หน้าเข้าสู้ระบบ'),
                  icon: const Icon(Icons.login_rounded),
                  style: ElevatedButton.styleFrom(
                    primary: ThemeBc.green05,
                    //side: BorderSide(color: Colors.red, width: 5),
                    textStyle: const TextStyle(fontSize: 15),
                    padding: const EdgeInsets.all(15),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    logout();
                  }),
            ),
            // CustomButton(
            //   title: 'เข้าสู่ระบบต่อไป',
            //   onPressed: () => Navigator.pushNamed(context, '/home-page'),
            //   colorButton: ThemeBc.white,
            //   textStyle:
            //       secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            // ),
          ],
        ),
      );
    }

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'คุณยังไม่ได้ยืยันอีเมล',
              style: primaryTextStyle.copyWith(
                fontSize: 22,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              imageSplash(),
              title(),
              button(),
            ],
          ),
        ),
      ),
    );
  }
}

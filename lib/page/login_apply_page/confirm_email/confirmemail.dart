import 'package:cctv_tun/shared/theme.dart';

import 'package:cctv_tun/widgets/widget_card.dart';
import 'package:flutter/material.dart';

class confirmemail extends StatelessWidget {
  const confirmemail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _secureText = true;
    Widget imageSplash() {
      return Container(
        margin: EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetBalanceCard(
              currentBalance: '',
              image: 'assets/uif-u/02.png',
            ),
          ],
        ),
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'คุณยังไม่ได้ยืนยันอีกเมล',
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
      appBar: AppBar(
        title: const Text('เทศบาลเมืองมหาสารคาม'),
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
      body: SafeArea(
        child: ListView(
          children: [
            imageSplash(),
            title(),
          ],
        ),
      ),
    );
  }
}

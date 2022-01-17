import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class appeal_page extends StatelessWidget {
  const appeal_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageSplash() {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('สายด่วน'),
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
            SizedBox(height: 5),
            buildbutton(),
            buildbutton1(),
            buildbutton2(),
          ],
        ),
      ),
    );
  }

  Widget buildbutton() {
    final number = '199';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            'ตำตรวจ',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          subtitle: Text(number),
          trailing: Material(
            elevation: 18,
            color: Colors.orange,
            shadowColor: Colors.grey,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange))),
              child: Text(
                'call',
              ),
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber(number);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildbutton1() {
    final number = '043-245265';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            'ศูตรขอนแก่น',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          subtitle: Text(number),
          trailing: Material(
            elevation: 18,
            color: Colors.orange,
            shadowColor: Colors.grey,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange))),
              child: Text(
                'call',
              ),
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber(number);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildbutton2() {
    final number = '083-6842051';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            'ตั้นคนโสดน่าาา',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          subtitle: Text(number),
          trailing: Material(
            elevation: 18,
            color: Colors.orange,
            shadowColor: Colors.grey,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange))),
              child: Text(
                'call',
              ),
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber(number);
              },
            ),
          ),
        ),
      ),
    );
  }
}

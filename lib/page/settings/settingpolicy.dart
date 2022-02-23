import 'dart:convert';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app/profile_action.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';

import 'package:cctv_tun/widgets/custom_buttonmenu.dart';
import 'package:cctv_tun/widgets/custom_buttonpolicy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingpolicy extends StatefulWidget {
  settingpolicy({Key? key}) : super(key: key);

  @override
  _settingpolicyState createState() => _settingpolicyState();
}

class _settingpolicyState extends State<settingpolicy>
    with SingleTickerProviderStateMixin {
  final tabList = ['ภาษาไทย', 'English', 'China'];
  late TabController _tabController;

  var id;
  bool _condition = true;

  double? lat, lng;

  var application;
  var app_agreement;
  var app_agreement_en;
  var app_agreement_cn;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> appToken =
        json.decode(prefs.getString('application').toString());
    // print(appToken['access_token']);

    setState(() {
      app_agreement = appToken['app_agreement_th'] ?? '';
      app_agreement_en = appToken['app_agreement_en'] ?? '';
      app_agreement_cn = appToken['app_agreement_cn'] ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('app');
    //กลับไปที่หน้า Login
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Widget settingpolicyTH() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        height: 1000,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Material(
              elevation: 18,
              shadowColor: Colors.grey[700],
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeBc.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 4),
                            blurRadius: 7.0,
                            spreadRadius: 1.0),
                      ]),
                  height: 1000,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Container(
                          child: Text(
                            '  $app_agreement',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              // backgroundColor: Colors.black45,
                              color: ThemeBc.textblack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget settingpolicyCH() {
      return Container(
        height: 1000,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Material(
              elevation: 18,
              shadowColor: Colors.grey[700],
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeBc.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 4),
                            blurRadius: 7.0,
                            spreadRadius: 1.0),
                      ]),
                  height: 1000,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Container(
                          child: Text(
                            '  $app_agreement_cn',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              // backgroundColor: Colors.black45,
                              color: ThemeBc.textblack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget settingpolicyEN() {
      return Container(
        height: 1000,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Material(
              elevation: 18,
              shadowColor: Colors.grey[700],
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeBc.white,
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
                  height: 1000,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Container(
                          child: Text(
                            '  $app_agreement_en',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              // backgroundColor: Colors.black45,
                              color: ThemeBc.textblack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Column(
          children: [
            Center(child: const Text('เทศบาลเมืองมหาสารคาม')),
          ],
        ),
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
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          // indicator: PointTabIndicator(
          //   position: PointTabIndicatorPosition.bottom,
          //   color: white,
          //   insets: EdgeInsets.only(bottom: 6),
          // ),
          tabs: tabList.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: TabBarView(
          controller: _tabController,
          children: tabList.map((item) {
            if (item == 'ภาษาไทย') {
              return settingpolicyTH();
            } else {
              return TabBarView(
                controller: _tabController,
                children: tabList.map((item) {
                  if (item == 'English') {
                    return settingpolicyEN();
                  } else {
                    return settingpolicyCH();
                  }

                  // print(item);
                  // return Center(child: Text(item));
                }).toList(),
              );
            }

            // print(item);
            // return Center(child: Text(item));
          }).toList(),
        ),
      ),
    );
  }
}

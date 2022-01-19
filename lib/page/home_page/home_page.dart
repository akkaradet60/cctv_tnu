import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/manu/manu.dart';
import 'package:cctv_tun/page/otoproducts/products_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:cctv_tun/shared/theme.dart';

import 'package:cctv_tun/widgets/menus_custom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  late Map<String, dynamic> imgSlide;
  int _currentIndex = 0;
  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> appToken =
        json.decode(prefs.getString('token').toString());
    // print(appToken['access_token']);

    setState(() {
      Global.token = appToken['access_token'];
    });

    var newProfile = json.decode(prefs.getString('profile').toString());
    var newApplication = json.decode(prefs.getString('application').toString());
    // print(newProfile);
    // print(newApplication);
    //call redux action
    /* final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
    store.dispatch(updateApplicationAction(newApplication));*/
  }

  // Future<Map<String, dynamic>> getDataSlide() async {
  //   var url =
  //       'https://www.bc-official.com/api/app_nt/api/app/otop/product/image/restful/?producti_product_id=6';
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Authorization':
  //         'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
  //   });

  //   if (response.statusCode == 200) {
  //     imgSlide = json.decode(response.body);

  //     // print(imgSlide['data'].length);
  //     return imgSlide;
  //   } else {
  //     throw Exception('$response.statusCode');
  //   }
  // }

  @override
  var porfile;
  @override
  void initState() {
    super.initState();
    getprofile1();
    getProfile();
  }

  Future<void> getprofile1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      porfile = json.decode(prefs.getString('profile').toString());
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('roke');
    await prefs.remove('profile');

    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  Widget build(BuildContext context) {
    Widget slider() {
      int _curr = 0;
      final List<String> images = [
        'assets/homepage/1.png',
        'assets/homepage/2.png',
        'assets/homepage/3.png',
        'assets/homepage/4.png',
      ];
      final List<String> places = [
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      List<Widget> generateImagesTiles() {
        return images
            .map((element) => ClipRRect(
                  child: Image.asset(
                    element,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ))
            .toList();
      }

      return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            CarouselSlider(
                items: generateImagesTiles(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 35 / 15,
                    onPageChanged: (index, other) {
                      setState(() {
                        _curr = index;
                      });
                    })), //setState
            AspectRatio(
              aspectRatio: 35 / 15,
              child: Center(
                child: Center(
                  child: Text(
                    places[_curr],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 15),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget titleMenus() {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 5),
          child: Text(
            'เมนู',
            style: primaryTextStyle.copyWith(fontSize: 25, fontWeight: medium),
          ),
        ),
      );
    }

    Widget cardMenus() {
      return Container(
          margin: EdgeInsets.only(top: 18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_1.png',
                      titleMenus: 'แจ้งเหตุฉุกเฉิน',
                      pathName: '/warn_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_2.png',
                      titleMenus: 'ร้องเรียน',
                      pathName: '/hotline_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_3.png',
                      titleMenus: 'สายด่วน',
                      pathName: '/appeal_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_4.png',
                      titleMenus: 'ข่าวสาร',
                      pathName: '/messge_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_5.png',
                      titleMenus: 'ปฎิทินการอบรม',
                      pathName: '/trainingcalendar',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_6.png',
                      titleMenus: 'CCTV',
                      pathName: '/cctv',
                      titleMenus2: '',
                      titleMenus1: '',
                    ),
                  ],
                ),
              ],
            ),
          ));
    }

    Widget cardMenus1() {
      return Container(
        margin: EdgeInsets.only(top: 18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_7.png',
                      titleMenus: 'รางวัล',
                      pathName: '/reward',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_8.png',
                      titleMenus: 'YOUTUBE',
                      pathName: '/youtube',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_9.png',
                      titleMenus: 'คู่มือการใช้งาน',
                      pathName: '/Manual_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_10.png',
                    titleMenus: 'ท่องเที่ยว',
                    pathName: '/travel',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_11.png',
                    titleMenus: 'สินค้า OTOP',
                    pathName: '/productshome_page',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_12.png',
                    titleMenus: 'สถานที่ราชการ',
                    pathName: '/map_page',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget tt(BuildContext context) {
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container();
        },
      );
    }

    return Scaffold(
      drawer: manu(),
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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: <Widget>[
              slider(),
              titleMenus(),
              cardMenus(),
              cardMenus1(),
              SizedBox(height: 111),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/login/login.page.dart';
import 'package:cctv_tun/page/menu/manu.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

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
    Map<String, dynamic> appuser_id =
        json.decode(prefs.getString('user_id').toString());
    setState(() {
      Global.token = appToken['access_token'];
      Global.user_id = appuser_id['access_id'];
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

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = Global.urlWeb +
        'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=1';
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
    });

    if (response.statusCode == 200) {
      imgSlide = json.decode(response.body);

      // print(imgSlide['data'].length);
      return imgSlide;
    } else {
      throw Exception('$response.statusCode');
    }
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
    getDataSlide();
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

    Widget slide(BuildContext context) {
      return Container(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getDataSlide(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return ListView.separated(
              //     itemBuilder: (context, index) {
              // return Text('3232');
              return CarouselSlider.builder(
                itemCount: snapshot.data!['data'].length,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 2,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                itemBuilder:
                    (BuildContext context, int item, int pageViewIndex) =>

                        // Text('${snapshot.data!['data'][item]['blog_id']}');
                        //     Container(
                        //   child: Center(child: Text(item.toString())),
                        //   color: Colors.green,
                        // ),
                        NeumorphicButton(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    // boxShape:
                    //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                    // boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/messagemdetail_page',
                          arguments: {
                            'blog_images': snapshot.data!['data'][item]
                                        ['blog_images'] !=
                                    null
                                ? Global.domainImage +
                                    snapshot.data!['data'][item]['blog_images']
                                        [0]['blogi_path_name']
                                : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                            'blog_name': snapshot.data!['data'][item]
                                ['blog_name'],
                            'blog_detail': snapshot.data!['data'][item]
                                ['blog_detail']

                            /*   'id': data[index].id,
                                'detail': data[index].detail,
                                'picture': data[index].picture,
                                'view': data[index].view,*/
                          });
                    },
                    // child: Card(
                    //   margin: EdgeInsets.only(
                    //     top: 10.0,
                    //     bottom: 10.0,
                    //   ),
                    //   elevation: 6.0,
                    // shadowColor: Colors.redAccent,
                    // shape: RoundedRectangleBorder(
                    //     // borderRadius: BorderRadius.circular(30.0),
                    //     ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: secondaryTextColor,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 7,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 4),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ]),
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                snapshot.data!['data'][item]['blog_images'][0]
                                            ['blogi_path_name'] !=
                                        null
                                    ? Global.domainImage +
                                        snapshot.data!['data'][item]
                                                ['blog_images'][0]
                                            ['blogi_path_name']
                                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Center(
                                child: Text(
                                  // '${titles[_currentIndex]}',
                                  '${snapshot.data!['data'][item]['blog_name']}',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.black45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
            }

            return Center(child: CircularProgressIndicator());
          },
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
                      pathName: '/compose_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_3.png',
                      titleMenus: 'สายด่วน',
                      pathName: '/hotlinee_page',
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
                      pathName: '/message_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_5.png',
                      titleMenus: 'การฝึกอบรม',
                      pathName: '/trainingcalendar_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_6.png',
                      titleMenus: 'CCTV',
                      pathName: '/cctv_page',
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
                      pathName: '/award_page',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_10.png',
                      titleMenus: 'ท่องเที่ยว',
                      pathName: '/travel_page',
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
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_11.png',
                    titleMenus: 'สินค้า OTOP',
                    pathName: '/productshome_page',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  SizedBox(width: 48),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_12.png',
                    titleMenus: 'สถานที่ราชการ',
                    pathName: '/location_page',
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
      drawer: menu_pang(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Center(child: const Text('เทศบาลเมืองมหาสารคาม')),
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
      body: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ThemeBc.white, ThemeBc.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 15),
                slide(context), // slider(),
                titleMenus(),
                cardMenus(),
                cardMenus1(),
                SizedBox(height: 111),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

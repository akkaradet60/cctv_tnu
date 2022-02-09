import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:cctv_tun/page/menu/manu.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

import 'package:cctv_tun/widgets/menus_custom.dart';

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

      // Global.user_name= appuser_id['access_name'];
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
        'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=${Global.glog_catid}';
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
  late List<String> titles = [
    ' 1 ',
    ' 2 ',
    ' 3 ',
    ' 4 ',
    ' 5',
    '6',
    '7',
    '8',
  ];

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
              if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeBc.text,
                        borderRadius: BorderRadius.circular(
                          20,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ไม่พบข้อมูล'),
                    ),
                  ),
                );
              } else {
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
                                              ['blog_images'][0]
                                          ['blogi_path_name'] !=
                                      null
                                  ? Global.domainImage +
                                      snapshot.data!['data'][item]
                                          ['blog_images'][0]['blogi_path_name']
                                  : '${Global.networkImage}',
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
                            child: ListView(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Image.network(
                                      snapshot.data!['data'][item]
                                                      ['blog_images'][0]
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
                                    Column(
                                      children: [
                                        SizedBox(height: 160),
                                        Container(
                                          color: ThemeBc.black,
                                          height: 40,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                // '${titles[_currentIndex]}',
                                                '${snapshot.data!['data'][item]['blog_name']}',
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              ;
              // return ListView.separated(
              //     itemBuilder: (context, index) {
              // return Text('3232');

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
          // margin: EdgeInsets.only(top: 30, left: 5),
          child: LocaleText(
            'เมนู',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              // backgroundColor: Colors.black45,
              color: ThemeBc.white,
            ),
          ),
        ),
      );
    }

    // Widget ssss() {
    //   return Container(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text(
    //             LocaleKeys.hi_text.tr(),
    //           ),
    //           Text(
    //             LocaleKeys.this_should_be_translated.tr(),
    //           ),
    //           const SizedBox(height: 15),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               Card(
    //                 child: Text('sdsd'),
    //               ),
    //               // ElevatedButton(
    //               //   onPressed: () async {
    //               //     await context.setLocale(Locale('en'));
    //               //   },
    //               //   child: Text(
    //               //     "English",
    //               //   ),
    //               // ),
    //               ElevatedButton(
    //                 onPressed: () async {
    //                   await context.setLocale(Locale('th'));
    //                 },
    //                 child: Text(
    //                   "TH",
    //                 ),
    //               ),

    //               ElevatedButton(
    //                 onPressed: () async {
    //                   await context.setLocale(Locale('en'));
    //                 },
    //                 child: Text(
    //                   "English",
    //                 ),
    //               ),
    //               // ElevatedButton(
    //               //   onPressed: () async {
    //               //     await context.setLocale(Locale('ar'));
    //               //   },
    //               //   child: Text(
    //               //     "العربية",
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

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
                      titleMenus: 'โทรทัศน์วงจรปิด',
                      pathName: '/AppealPage',
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
                    titleMenus: 'สินค้าโอทอป',
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

    return Scaffold(
      drawer: menu_pang(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Container(
              height: 30,
              width: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  LocaleText('เทศบาลเมืองมหาสารคาม'),
                ],
              ),
            )
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
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ThemeBc.orange, ThemeBc.pinkAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 15),
                slide(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: titles.map((urlOfItem) {
                      int index = titles.indexOf(urlOfItem);
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? const Color.fromRGBO(255, 102, 0, 0.9)
                              : const Color.fromRGBO(255, 255, 255, 0.8),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // alert // slider()
                titleMenus(),
                cardMenus(),
                cardMenus1(),

                // ssss(),
                SizedBox(height: 111),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

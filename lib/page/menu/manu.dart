import 'dart:convert';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class menu_pang extends StatefulWidget {
  menu_pang({Key? key}) : super(key: key);

  @override
  _menu_pangState createState() => _menu_pangState();
}

class _menu_pangState extends State<menu_pang> {
  bool isLoading = true;

  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = Global.urlWeb +
        'api/profile/restful?user_id=${Global.user_id}&user_app_id=${Global.app_id}';
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

  var newProfile;
  var profile;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newProfile = json.decode(prefs.getString('profile').toString());
    //call redux action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
  }

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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      child: Drawer(
        backgroundColor: ThemeBc.background,
        child: Container(
          child: ListView(
            children: [
              Container(
                height: 1000,
                child: FutureBuilder<Map<String, dynamic>>(
                  future: getDataSlide(),
                  builder: (context, snapshot) {
                    if (Global.user_id == '111') {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!['data'].length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 300,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 7.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(height: 5),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 18),
                                                      Center(
                                                        child: LocaleText(
                                                          'ผู้ชม',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                ThemeBc.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 342,
                                      height: 50,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: CircleBorder(),
                                                // elevation: 100,
                                                content: Container(
                                                  height: 200,
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.background,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(2, 2),
                                                            blurRadius: 7,
                                                            spreadRadius: 1.0),
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(2, 4),
                                                            blurRadius: 7.0,
                                                            spreadRadius: 1.0),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 20),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              LocaleNotifier.of(
                                                                      context)!
                                                                  .change('th');
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/home_page');
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 250,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        20,
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            2),
                                                                        blurRadius:
                                                                            7,
                                                                        spreadRadius:
                                                                            1.0),
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                        blurRadius:
                                                                            7.0,
                                                                        spreadRadius:
                                                                            1.0),
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'ภาษาไทย',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      // backgroundColor: Colors.black45,
                                                                      color: ThemeBc
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          InkWell(
                                                            onTap: () {
                                                              LocaleNotifier.of(
                                                                      context)!
                                                                  .change('en');
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/home_page');
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 250,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        20,
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            2),
                                                                        blurRadius:
                                                                            7,
                                                                        spreadRadius:
                                                                            1.0),
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                        blurRadius:
                                                                            7.0,
                                                                        spreadRadius:
                                                                            1.0),
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'English',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      // backgroundColor: Colors.black45,
                                                                      color: ThemeBc
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          InkWell(
                                                            onTap: () {
                                                              LocaleNotifier.of(
                                                                      context)!
                                                                  .change('zh');
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/home_page');
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 250,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        20,
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            2),
                                                                        blurRadius:
                                                                            7,
                                                                        spreadRadius:
                                                                            1.0),
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                        blurRadius:
                                                                            7.0,
                                                                        spreadRadius:
                                                                            1.0),
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    '中国',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      // backgroundColor: Colors.black45,
                                                                      color: ThemeBc
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.spellcheck,
                                          color: Colors.black,
                                        ),
                                        label: LocaleText(
                                          "เปลี่ยนภาษา",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.white,
                                          shadowColor: Colors.grey[700],
                                          elevation: 30,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryTextColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 7,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 4),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ]),
                                      height: 50,
                                      child: ListTile(
                                        leading: Icon(Icons.stairs),
                                        title: LocaleText('หน้าหลัก'),
                                        trailing: Icon(Icons.double_arrow),
                                        selected: ModalRoute.of(context)
                                                    ?.settings
                                                    .name ==
                                                '/home_page'
                                            ? true
                                            : false,
                                        //  iconColor: Colors.orange,
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamedAndRemoveUntil(
                                                  '/home_page',
                                                  (route) => false);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryTextColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 7,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 4),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ]),
                                      height: 50,
                                      child: ListTile(
                                        leading: Icon(Icons.logout),
                                        title: LocaleText('ออกจากระบบ'),
                                        trailing: Icon(Icons.double_arrow),
                                        onTap: () {
                                          logout();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                      }
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!['data'].length,
                          itemBuilder: (context, index) {
                            var imageData = Global.networkImage;

                            if (snapshot.data!['data'][index]['user_image'] !=
                                    null &&
                                snapshot.data!['data'][index]
                                        ['user_image_check'] ==
                                    '1') {
                              imageData = Global.urlFile2 +
                                  snapshot.data!['data'][index]['user_image'];
                            } else if (snapshot.data!['data'][index]
                                        ['user_image'] !=
                                    null &&
                                snapshot.data!['data'][index]
                                        ['user_image_check'] ==
                                    '2') {
                              imageData = Global.networkImage;
                            }
                            return Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 300,
                                        height: 350,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 7.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 300,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.background,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                      boxShadow: []),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 15),
                                                      Container(
                                                        width: 150,
                                                        height: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      imageData),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  LocaleText(
                                                    'ชื่อ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ThemeBc.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' : ${snapshot.data!['data'][index]['user_firstname']}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ThemeBc.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  LocaleText(
                                                    'นามสกุล',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ThemeBc.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          ' : ${snapshot.data!['data'][index]['user_lastname']}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                ThemeBc.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 260,
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        LocaleText(
                                                          'อีเมล',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                ThemeBc.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' : ${snapshot.data!['data'][index]['user_email']}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                ThemeBc.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryTextColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 7,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 4),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ]),
                                      height: 50,
                                      child: ListTile(
                                        leading: Icon(Icons.stairs),
                                        title: LocaleText('หน้าหลัก'),
                                        trailing: Icon(Icons.double_arrow),
                                        selected: ModalRoute.of(context)
                                                    ?.settings
                                                    .name ==
                                                '/home_page'
                                            ? true
                                            : false,
                                        //  iconColor: Colors.orange,
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamedAndRemoveUntil(
                                                  '/home_page',
                                                  (route) => false);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryTextColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 7,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 4),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ]),
                                      height: 50,
                                      child: ListTile(
                                        leading: Icon(Icons.settings),
                                        title: LocaleText('ตั้งค่า'),
                                        trailing: Icon(Icons.double_arrow),
                                        selected: ModalRoute.of(context)
                                                    ?.settings
                                                    .name ==
                                                '/settings'
                                            ? true
                                            : false,
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamedAndRemoveUntil(
                                                  '/settings',
                                                  (route) => false);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryTextColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 7,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 4),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ]),
                                      height: 50,
                                      child: ListTile(
                                        leading: Icon(Icons.logout),
                                        title: LocaleText('ออกจากระบบ'),
                                        trailing: Icon(Icons.double_arrow),
                                        onTap: () {
                                          logout();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                      }
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

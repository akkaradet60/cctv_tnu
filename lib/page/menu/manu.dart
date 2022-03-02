import 'dart:convert';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
      decoration: BoxDecoration(
          // color: ThemeBc.black,
          borderRadius: BorderRadius.circular(
            0,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(2, 2),
                blurRadius: 7,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.pinkAccent],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(height: 5),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 18),
                                                      Center(
                                                        child: LocaleText(
                                                          'ผู้ชม',
                                                          style: GoogleFonts
                                                              .sarabun(
                                                            textStyle:
                                                                TextStyle(
                                                              color: ThemeBc
                                                                  .textblack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 50),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      boxShadow: []),
                                                  height: 50,
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.spellcheck,
                                                      color: ThemeBc.black,
                                                    ),
                                                    title: LocaleText(
                                                      'เปลี่ยนภาษา',
                                                      style:
                                                          GoogleFonts.sarabun(
                                                        textStyle: TextStyle(
                                                          color:
                                                              ThemeBc.textblack,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons.double_arrow,
                                                      color: ThemeBc.black,
                                                    ),

                                                    //  iconColor: Colors.white,
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        30)),
                                                            // shape: CircleBorder(
                                                            //     side: BorderSide
                                                            //         .none),
                                                            // elevation: 100,
                                                            content: Container(
                                                              height: 180,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          LocaleNotifier.of(context)!
                                                                              .change('th');
                                                                          Navigator.pushNamedAndRemoveUntil(
                                                                              context,
                                                                              '/home_page',
                                                                              (route) => false);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              250,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ThemeBc.background,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'ภาษาไทย',
                                                                                style: GoogleFonts.sarabun(
                                                                                  textStyle: TextStyle(
                                                                                    color: ThemeBc.textwhite,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 15,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          LocaleNotifier.of(context)!
                                                                              .change('en');
                                                                          Navigator.pushNamedAndRemoveUntil(
                                                                              context,
                                                                              '/home_page',
                                                                              (route) => false);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              250,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ThemeBc.background,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'English',
                                                                                style: GoogleFonts.sarabun(
                                                                                  textStyle: TextStyle(
                                                                                    color: ThemeBc.textwhite,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 15,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          LocaleNotifier.of(context)!
                                                                              .change('zh');
                                                                          Navigator.pushNamedAndRemoveUntil(
                                                                              context,
                                                                              '/home_page',
                                                                              (route) => false);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              250,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ThemeBc.background,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '中国',
                                                                                style: GoogleFonts.sarabun(
                                                                                  textStyle: TextStyle(
                                                                                    color: ThemeBc.textwhite,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 15,
                                                                                  ),
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
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      boxShadow: []),
                                                  height: 50,
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.stairs,
                                                      color: ThemeBc.black,
                                                    ),
                                                    title: LocaleText(
                                                      'หน้าหลัก',
                                                      style:
                                                          GoogleFonts.sarabun(
                                                        textStyle: TextStyle(
                                                          color:
                                                              ThemeBc.textblack,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons.double_arrow,
                                                      color: ThemeBc.black,
                                                    ),
                                                    selected:
                                                        ModalRoute.of(context)
                                                                    ?.settings
                                                                    .name ==
                                                                '/home_page'
                                                            ? true
                                                            : false,
                                                    //  iconColor: Colors.white,
                                                    onTap: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pushNamedAndRemoveUntil(
                                                              '/home_page',
                                                              (route) => false);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      boxShadow: []),
                                                  height: 50,
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.logout,
                                                      color: ThemeBc.black,
                                                    ),
                                                    title: LocaleText(
                                                      'ออกจากระบบ',
                                                      style:
                                                          GoogleFonts.sarabun(
                                                        textStyle: TextStyle(
                                                          color:
                                                              ThemeBc.textblack,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons.double_arrow,
                                                      color: ThemeBc.black,
                                                    ),
                                                    onTap: () {
                                                      logout();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                          Map _userObj = {};
                          return Column(
                            children: [
                              Container(
                                height: 1000,
                                child: ListView.builder(
                                  itemCount: snapshot.data!['data'].length,
                                  itemBuilder: (context, index) {
                                    var imageData = Global.networkImage;

                                    if (snapshot.data!['data'][index]
                                                ['user_image'] !=
                                            null &&
                                        snapshot.data!['data'][index]
                                                ['user_image_check'] ==
                                            '1') {
                                      imageData = Global.urlFile2 +
                                          snapshot.data!['data'][index]
                                              ['user_image'];
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
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Container(
                                                    width: 300,
                                                    height: 500,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                        boxShadow: []),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            child: Container(
                                                              width: 300,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Container(
                                                                    width: 130,
                                                                    height: 130,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                              imageData),
                                                                          fit: BoxFit
                                                                              .fill),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ThemeBc
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                    boxShadow: []),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      LocaleText(
                                                                        'ชื่อ',
                                                                        style: GoogleFonts
                                                                            .sarabun(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeBc.textblack,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ' ${snapshot.data!['data'][index]['user_firstname']}' !=
                                                                                null
                                                                            ? '${snapshot.data!['data'][index]['user_firstname']}'
                                                                            : _userObj["name"],
                                                                        style: GoogleFonts
                                                                            .sarabun(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeBc.textblack,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      LocaleText(
                                                                        'นามสกุล',
                                                                        style: GoogleFonts
                                                                            .sarabun(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeBc.textblack,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text(
                                                                              '${snapshot.data!['data'][index]['user_lastname']}' != null ? '${snapshot.data!['data'][index]['user_lastname']}' : _userObj["user_lastname"],
                                                                              style: GoogleFonts.sarabun(
                                                                                textStyle: TextStyle(
                                                                                  color: ThemeBc.textblack,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            )
                                                                            // Text(
                                                                            //   ' : ${snapshot.data!['data'][index]['user_lastname']}',
                                                                            //   style: TextStyle(
                                                                            //     fontSize: 16,
                                                                            //     fontWeight:
                                                                            //         FontWeight.bold,
                                                                            //     color:
                                                                            //         ThemeBc.black,
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            260,
                                                                        child:
                                                                            ListView(
                                                                          children: [
                                                                            LocaleText(
                                                                              'อีเมล',
                                                                              style: GoogleFonts.sarabun(
                                                                                textStyle: TextStyle(
                                                                                  color: ThemeBc.textblack,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 5),
                                                                            Text(
                                                                              '${snapshot.data!['data'][index]['user_email']}' != null ? '${snapshot.data!['data'][index]['user_email']}' : _userObj["user_email"],
                                                                              style: GoogleFonts.sarabun(
                                                                                textStyle: TextStyle(
                                                                                  color: ThemeBc.textblack,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            // Text(
                                                                            //   ' : ${snapshot.data!['data'][index]['user_email']}',
                                                                            //   style: TextStyle(
                                                                            //     fontSize: 16,
                                                                            //     fontWeight:
                                                                            //         FontWeight.bold,
                                                                            //     color:
                                                                            //         ThemeBc.black,
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          SizedBox(height: 20),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                      boxShadow: []),
                                                              height: 50,
                                                              child: ListTile(
                                                                leading: Icon(
                                                                  Icons.stairs,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                title:
                                                                    LocaleText(
                                                                  'หน้าหลัก',
                                                                  style: GoogleFonts
                                                                      .sarabun(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: ThemeBc
                                                                          .textblack,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                trailing: Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                selected: ModalRoute.of(context)
                                                                            ?.settings
                                                                            .name ==
                                                                        '/home_page'
                                                                    ? true
                                                                    : false,
                                                                //  iconColor: Colors.white,
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true)
                                                                      .pushNamedAndRemoveUntil(
                                                                          '/home_page',
                                                                          (route) =>
                                                                              false);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                      boxShadow: []),
                                                              height: 50,
                                                              child: ListTile(
                                                                leading: Icon(
                                                                  Icons
                                                                      .settings,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                title:
                                                                    LocaleText(
                                                                  'ตั้งค่า',
                                                                  style: GoogleFonts
                                                                      .sarabun(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: ThemeBc
                                                                          .textblack,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                trailing: Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                selected: ModalRoute.of(context)
                                                                            ?.settings
                                                                            .name ==
                                                                        '/settings'
                                                                    ? true
                                                                    : false,
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true)
                                                                      .pushNamedAndRemoveUntil(
                                                                          '/settings',
                                                                          (route) =>
                                                                              false);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: ThemeBc
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.2),
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                        blurRadius:
                                                                            7.0,
                                                                        spreadRadius:
                                                                            1.0),
                                                                  ]),
                                                              height: 50,
                                                              child: ListTile(
                                                                leading: Icon(
                                                                  Icons.logout,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                title:
                                                                    LocaleText(
                                                                  'ออกจากระบบ',
                                                                  style: GoogleFonts
                                                                      .sarabun(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: ThemeBc
                                                                          .textblack,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                trailing: Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  color: ThemeBc
                                                                      .black,
                                                                ),
                                                                onTap: () {
                                                                  logout();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

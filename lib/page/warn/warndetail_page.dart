import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class warndetail_page extends StatefulWidget {
  warndetail_page({Key? key}) : super(key: key);

  @override
  State<warndetail_page> createState() => _composedetail_page();
}

class _composedetail_page extends State<warndetail_page>
    with TickerProviderStateMixin {
  var datail_blogpose;
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/emergency/restful/?em_app_id=${Global.app_id}&em_category=0&em_user_id=${Global.user_id}');
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

  @override
  Widget build(BuildContext context) {
    datail_blogpose = ModalRoute.of(context)!.settings.arguments;

    var status_name = 'ตรวจสอบแล้ว';
    var status_color = Color.fromARGB(255, 9, 172, 28);
    if (datail_blogpose['em_status'] == '1') {
      status_name = 'รอรับเรื่อง';
      status_color = ThemeBc.red;
    }
    if (datail_blogpose['em_status'] == '2') {
      status_name = 'รับเรื่องแล้ว';
      status_color = ThemeBc.yellow;
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.app_white_color, //change your color here
          ),
          foregroundColor: ThemeBc.app_white_color,
          backgroundColor: ThemeBc.app_theme_color,
          title: Center(
              child: Text(
            '${datail_blogpose['emt_name'] ?? '-'}',
            style: GoogleFonts.sarabun(
              textStyle: TextStyle(
                color: ThemeBc.app_textwhite_color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: ThemeBc.app_linear_on,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            ThemeBc.app_white_color,
            ThemeBc.app_white_color,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          height: 1000,
          width: 1000,
          child: Container(
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.white],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft)),
                        height: 300,
                        width: 1000,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: getDataSlide(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ThemeBc.app_textblack_color,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
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
                                      itemBuilder: (BuildContext context,
                                              int item, int pageViewIndex) =>

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

                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            child: ListView(
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Image.network(
                                                      datail_blogpose[
                                                          'em_images'],
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                      child: Text(
                                          'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                                }

                                return Center(
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'รอสักหน่อยนะครับ',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   child: Column(
                //     children: [
                //       Container(
                //         height: 300,
                //         child: Card(
                //           child:
                //               Image.network('${datail_blogpose['em_images']}'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  height: 500,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 390,
                              height: 280,
                              child: ListView(
                                children: [
                                  Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'ชื่อผู้แจ้ง : ',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${datail_blogpose['em_owner']}',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'ประเภท : ',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${datail_blogpose['emt_name'] ?? '-'}',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'สถานะ : ',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$status_name',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: status_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            '   ${datail_blogpose['em_detail']}',
                                            style: GoogleFonts.sarabun(
                                              textStyle: TextStyle(
                                                color:
                                                    ThemeBc.app_textblack_color,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'เบอร์ติดต่อที่คุณแจ้ง : ${datail_blogpose['em_phone']}',
                                            style: GoogleFonts.sarabun(
                                              textStyle: TextStyle(
                                                color:
                                                    ThemeBc.app_textblack_color,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'จุดเกิดเหตุ : ${datail_blogpose['em_lat']} ${datail_blogpose['em_lng']}',
                                            style: GoogleFonts.sarabun(
                                              textStyle: TextStyle(
                                                color:
                                                    ThemeBc.app_textblack_color,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

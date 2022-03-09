import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class messagemdetail_page extends StatefulWidget {
  messagemdetail_page({Key? key}) : super(key: key);

  @override
  _messagemdetail_page createState() => _messagemdetail_page();
}

class _messagemdetail_page extends State<messagemdetail_page> {
  var productt;
  var detail;
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=${Global.glog_catid}');
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

  // var _counter = 1;
  // var _product = int.parse('0');
  // var _product1 = int.parse('0');

  /* void _incrementCounter() {
    setState(() {
      _counter++;
      _product = _product + _product1;
    });
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // }

    productt = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.app_white_color, //change your color here
          ),
          foregroundColor: ThemeBc.app_white_color,
          backgroundColor: ThemeBc.app_theme_color,
          title: Column(
            children: [
              Text(
                '${productt['blog_name']}',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.app_textwhite_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
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
          height: 1000,
          width: 1000,
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: getDataSlide(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ThemeBc.app_linear_on,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ไม่พบข้อมูล',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          // backgroundColor: Colors.black45,
                                          color: ThemeBc.app_textwhite_color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                              itemBuilder: (BuildContext context, int item,
                                      int pageViewIndex) =>

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
                                      Radius.circular(10.0),
                                    ),
                                    child: ListView(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Image.network(
                                              productt['blog_images'],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(height: 160),
                                              ],
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

                          // return ListView.separated(
                          //     itemBuilder: (context, index) {
                          // return Text('3232');

                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                        }

                        return Center(
                            child: SpinKitThreeInOut(
                          color: ThemeBc.app_linear_on,
                        ));
                      },
                    ),
                  ),
                ),
                Container(
                  height: 300,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${productt['blog_name']}',
                                          style: GoogleFonts.sarabun(
                                            textStyle: TextStyle(
                                              color:
                                                  ThemeBc.app_textblack_color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '  ${productt['blog_detail']}',
                                          style: TextStyle(
                                            fontSize: 15.0,

                                            // backgroundColor: Colors.black45,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

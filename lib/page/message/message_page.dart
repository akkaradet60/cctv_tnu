import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/models/message/message.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class messge_page extends StatefulWidget {
  messge_page({Key? key}) : super(key: key);

  @override
  _messge_pageState createState() => _messge_pageState();
}

class _messge_pageState extends State<messge_page> {
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url =
        'https://www.bc-official.com/api/app_nt/api/app/blog/restful/?app_id=1&blog_id=2';
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
  void initState() {
    super.initState();
    getDataSlide();
  }

  @override
  Widget build(BuildContext context) {
    double targetValue = 24.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.orangeAccent],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        'ข่าวทั้งหมด',
                        style: primaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium),
                      ),
                    ),
                  ),
                ),
                Container(
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
                          itemBuilder: (BuildContext context, int item,
                                  int pageViewIndex) =>

                              // Text('${snapshot.data!['data'][item]['blog_id']}');
                              //     Container(
                              //   child: Center(child: Text(item.toString())),
                              //   color: Colors.green,
                              // ),
                              NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              // boxShape:
                              //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                              // boxShape: NeumorphicBoxShape.circle(),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(0),
                            child: Card(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              elevation: 6.0,
                              // shadowColor: Colors.redAccent,
                              // shape: RoundedRectangleBorder(
                              //     // borderRadius: BorderRadius.circular(30.0),
                              //     ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      snapshot.data!['data'][item]
                                              ['blog_images'][item]
                                          ['blogi_path_name'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Center(
                                      child: Text(
                                        // '${titles[_currentIndex]}',
                                        '${snapshot.data!['data'][item]['blog_name']}',
                                        style: const TextStyle(
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
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

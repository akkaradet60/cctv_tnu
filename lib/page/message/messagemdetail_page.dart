import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Text('${productt['blog_name']}'),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/logo.png', scale: 15),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ThemeBc.orange, ThemeBc.pinkAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          height: 1000,
          width: 1000,
          child: Container(
            color: ThemeBc.background,
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.pinkAccent,
                              Colors.orangeAccent
                            ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft)),
                        height: 300,
                        width: 1000,
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
                                    Card(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Image.network(
                                            productt['blog_images'],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        // Center(
                                        //   child: Text(
                                        //     // '${titles[_currentIndex]}',
                                        //     '${snapshot.data!['data'][item]['blog_name']}',
                                        //     style: TextStyle(
                                        //       fontSize: 24.0,
                                        //       fontWeight: FontWeight.bold,
                                        //       backgroundColor: Colors.black45,
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                //     Card(
                                //   child: ListView(
                                //     children: [
                                //       ClipRRect(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(8.0),
                                //         ),
                                //         child: Stack(
                                //           children: <Widget>[
                                //             Image.network(
                                //               productt['blog_images'],
                                //               fit: BoxFit.cover,
                                //               width: double.infinity,
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],

                                //     //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                //     // boxShape: NeumorphicBoxShape.circle(),
                                //   ),

                                // ),

                                // shadowColor: Colors.redAccent,
                                // shape: RoundedRectangleBorder(
                                //blog_images//     // borderRadius: BorderRadius.circular(30.0),
                                //     ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                            }

                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
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
                              decoration: BoxDecoration(
                                  color: ThemeBc.white,
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
                              width: 390,
                              height: 280,
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'ชื่อข่าว ${productt['blog_name']}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Colors.black45,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'เนื้อข่าว ${productt['blog_detail']}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
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

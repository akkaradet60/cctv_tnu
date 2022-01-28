import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class awarddetail_page extends StatefulWidget {
  awarddetail_page({Key? key}) : super(key: key);

  @override
  _awarddetail_page createState() => _awarddetail_page();
}

class _awarddetail_page extends State<awarddetail_page> {
  var productt;
  var detail;
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb + 'api/app/blog/restful/?app_id=${Global.app_id}');
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

  var _counter = 1;
  var _product = int.parse('0');
  var _product1 = int.parse('0');

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
    // void _incrementCounter() {
    //   _product1 = int.parse('${productt['productPrice']}');
    //   setState(() {
    //     _counter++;
    //     _product = _product + _product1;
    //   });
    // }

    // void _incrementCounterp() {
    //   setState(() {
    //     _product1 = int.parse('${productt['productPrice']}');
    //     _counter--;
    //     _product = _product - _product1;
    //     if (_counter < 0) {
    //       _counter = 0;
    //     }
    //     if (_product < 0) {
    //       _product = 0;
    //     }
    //   });
    // }

    productt = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.black,
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
          child: Container(
            color: ThemeBc.black,
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
                                    // ),
                                    ListView(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.network(
                                            productt['awardi_path_name'],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],

                                  //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                  // boxShape: NeumorphicBoxShape.circle(),
                                ),

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
                  height: 500,
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 410,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'ชื่อข่าว ${productt['award_name']}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      // backgroundColor: Colors.black45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'เนื้อข่าว ${productt['award_detail']}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          // backgroundColor: Colors.black45,
                                          color: Colors.white,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
    // Scaffold(
    //     appBar: AppBar(
    //       iconTheme: IconThemeData(
    //         color: ThemeBc.white, //change your color here
    //       ),
    //       shadowColor: ThemeBc.white,
    //       foregroundColor: ThemeBc.white,
    //       backgroundColor: ThemeBc.black,
    //       title: Text('${productt['award_name']}'),
    //       actions: <Widget>[
    //         IconButton(
    //           icon: Image.asset('assets/logo.png', scale: 15),
    //           tooltip: 'Show Snackbar',
    //           onPressed: () {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
    //           },
    //         ),
    //       ],
    //     ),
    //     body: Container(
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [Colors.pinkAccent, Colors.orangeAccent],
    //               begin: Alignment.topRight,
    //               end: Alignment.bottomLeft)),
    //       child: Padding(
    //         padding: EdgeInsets.all(10),
    //         child: Card(
    //           child: Container(

    //             child: Column(
    //               children: [
    //                 Container(
    //                   decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                           colors: [ThemeBc.orange,ThemeBc.pinkAccent],
    //                           begin: Alignment.topRight,
    //                           end: Alignment.bottomLeft)),
    //                   child: Container(
    //                      color: ThemeBc.black,
    //                         child: ListView(
    //                           children: [
    //                             Container(

    //                               child: FutureBuilder<Map<String, dynamic>>(
    //                                 future: getDataSlide(),
    //                                 builder: (context, snapshot) {
    //                                   if (snapshot.hasData) {
    //                                     // return ListView.separated(
    //                                     //     itemBuilder: (context, index) {
    //                                     // return Text('3232');
    //                                     return CarouselSlider.builder(
    //                                       itemCount:
    //                                           snapshot.data!['data'].length,
    //                                       options: CarouselOptions(
    //                                         autoPlay: true,
    //                                         enlargeCenterPage: true,
    //                                         viewportFraction: 0.9,
    //                                         aspectRatio: 2.0,
    //                                         initialPage: 2,
    //                                         onPageChanged: (index, reason) {
    //                                           setState(
    //                                             () {
    //                                               _currentIndex = index;
    //                                             },
    //                                           );
    //                                         },
    //                                       ),
    //                                       itemBuilder: (BuildContext context,
    //                                               int item,
    //                                               int pageViewIndex) =>

    //                                           // Text('${snapshot.data!['data'][item]['blog_id']}');
    //                                           //     Container(
    //                                           //   child: Center(child: Text(item.toString())),
    //                                           //   color: Colors.green,
    //                                           // ),
    //                                           NeumorphicButton(
    //                                         style: NeumorphicStyle(
    //                                           shape: NeumorphicShape.flat,
    //                                           // boxShape:
    //                                           //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
    //                                           // boxShape: NeumorphicBoxShape.circle(),
    //                                           color: Colors.white,
    //                                         ),
    //                                         child: Card(
    //                                           elevation: 6.0,
    //                                           // shadowColor: Colors.redAccent,
    //                                           // shape: RoundedRectangleBorder(
    //                                           //blog_images//     // borderRadius: BorderRadius.circular(30.0),
    //                                           //     ),
    //                                           child: ClipRRect(
    //                                             borderRadius: BorderRadius.all(
    //                                               Radius.circular(3.0),
    //                                             ),
    //                                             child: Stack(
    //                                               children: <Widget>[
    //                                                 Image.network(
    //                                                   productt[
    //                                                       'awardi_path_name'],
    //                                                   fit: BoxFit.cover,
    //                                                   width: double.infinity,
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     );
    //                                   } else if (snapshot.hasError) {
    //                                     return Center(
    //                                         child: Text(
    //                                             'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
    //                                   }

    //                                   return Center(
    //                                       child: CircularProgressIndicator());
    //                                 },
    //                               ),
    //                             ),
    //                           ],
    //                         ),

    //                   ),
    //                 ),
    //                 Container(
    //                   height: 500,
    //                   child: ListView(
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Container(
    //                             width: 370,
    //                             child: Column(
    //                               children: [
    //                                 Padding(
    //                                   padding: const EdgeInsets.all(8.0),
    //                                   child: Text(
    //                                     'รางวัล ${productt['award_name']}',
    //                                     style: primaryTextStyle.copyWith(
    //                                         fontSize: 18, fontWeight: medium),
    //                                   ),
    //                                 ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.all(8.0),
    //                                   child: Text(
    //                                     'เนื้อหารางวัล ${productt['award_detail']}',
    //                                     style: primaryTextStyle.copyWith(
    //                                         fontSize: 15, fontWeight: medium),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ));
  }
}

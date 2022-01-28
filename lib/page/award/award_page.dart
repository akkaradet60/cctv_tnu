import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/models/blogs/blogs.dart';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class award_page extends StatefulWidget {
  award_page({Key? key}) : super(key: key);

  @override
  _award_pageState createState() => _award_pageState();
}

class _award_pageState extends State<award_page> {
  List<Data> data = [];
  bool isLoading = true;
  var hotlinee;

  @override
  void initState() {
    super.initState();
  }

  var productt;
  var detail;

  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/award/restful/?award_app_id=${Global.app_id}');
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
  Widget build(BuildContext context) {
    Widget award_pageSlide(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
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
                      Navigator.pushNamed(context, '/awarddetail_page',
                          arguments: {
                            'awardi_path_name': snapshot.data!['data'][item]
                                            ['award_images'][0]
                                        ['awardi_path_name'] !=
                                    null
                                ? Global.domainImage +
                                    snapshot.data!['data'][item]['award_images']
                                        [0]['awardi_path_name']
                                : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                            'award_name': snapshot.data!['data'][item]
                                ['award_name'],
                            'award_detail': snapshot.data!['data'][item]
                                ['award_detail']

                            /*   'id': data[index].id,
                                'detail': data[index].detail,
                                'picture': data[index].picture,
                                'view': data[index].view,*/
                          });
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      elevation: 6.0,
                      // shadowColor: Colors.redAccent,
                      // shape: RoundedRectangleBorder(
                      //     // borderRadius: BorderRadius.circular(30.0),
                      //     ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              snapshot.data!['data'][item]['award_images'][0]
                                          ['awardi_path_name'] !=
                                      null
                                  ? Global.domainImage +
                                      snapshot.data!['data'][item]
                                              ['award_images'][0]
                                          ['awardi_path_name']
                                  : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Center(
                              child: Text(
                                // '${titles[_currentIndex]}',
                                '${snapshot.data!['data'][item]['award_name']}',
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

    Widget award_page(BuildContext context) {
      return Container(
        color: ThemeBc.black,
        margin: EdgeInsets.only(top: 10, bottom: 0),
        width: 1000,
        height: 500,
        child: FutureBuilder<Map<String, dynamic>>(
          future: getDataSlide(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/awarddetail_page',
                                  arguments: {
                                    'awardi_path_name': snapshot.data!['data']
                                                [index]['award_images'] !=
                                            null
                                        ? Global.domainImage +
                                            snapshot.data!['data'][index]
                                                    ['award_images'][0]
                                                ['awardi_path_name']
                                        : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                    'award_name': snapshot.data!['data'][index]
                                        ['award_name'],
                                    'award_detail': snapshot.data!['data']
                                        [index]['award_detail']

                                    /*   'id': data[index].id,
                                  'detail': data[index].detail,
                                  'picture': data[index].picture,
                                  'view': data[index].view,*/
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 0),
                              child: Column(
                                children: [
                                  SizedBox(width: defaultMargin),
                                  Container(
                                    height: 400,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color: secondaryTextColor,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(2, 2),
                                              blurRadius: 7,
                                              spreadRadius: 1.0),
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Container(
                                                  height: 200,
                                                  child: Image.network(
                                                    snapshot.data!['data']
                                                                        [index]
                                                                    ['award_images'][0]
                                                                [
                                                                'awardi_path_name'] !=
                                                            null
                                                        ? Global.domainImage +
                                                            snapshot.data!['data']
                                                                        [index][
                                                                    'award_images'][0]
                                                                [
                                                                'awardi_path_name']
                                                        : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 340,
                                              color: Colors.grey[200],
                                              height: 160,
                                              child: ListView(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'รางวัล: ${snapshot.data!['data'][index]['award_name']}',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    medium),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 0),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'เนื้อหารางวัล : ${snapshot.data!['data'][index]['award_detail']}',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    medium),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              // return ListView.separated(
              //     itemBuilder: (context, index) {
              // return Text('3232');
              // return CarouselSlider.builder(
              //   itemCount: snapshot.data!['data'].length,
              //   options: CarouselOptions(
              //     autoPlay: true,
              //     enlargeCenterPage: true,
              //     viewportFraction: 0.9,
              //     aspectRatio: 2.0,
              //     initialPage: 2,
              //     onPageChanged: (index, reason) {
              //       setState(
              //         () {
              //           _currentIndex = index;
              //         },
              //       );
              //     },
              //   ),
              //   itemBuilder:
              //       (BuildContext context, int item, int pageViewIndex) =>

              //           // Text('${snapshot.data!['data'][item]['blog_id']}');
              //           //     Container(
              //           //   child: Center(child: Text(item.toString())),
              //           //   color: Colors.green,
              //           // ),
              //           NeumorphicButton(
              //     style: NeumorphicStyle(
              //       shape: NeumorphicShape.flat,
              //       // boxShape:
              //       //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
              //       // boxShape: NeumorphicBoxShape.circle(),
              //       color: Colors.white,
              //     ),
              //     padding: EdgeInsets.all(0),
              //     child: Container(
              //       height: 20,
              //       child: Card(
              //         margin: EdgeInsets.only(
              //           top: 10.0,
              //           bottom: 10.0,
              //         ),
              //         elevation: 6.0,
              //         // shadowColor: Colors.redAccent,
              //         // shape: RoundedRectangleBorder(
              //         //     // borderRadius: BorderRadius.circular(30.0),
              //         //     ),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(3.0),
              //           ),
              //           child: Stack(
              //             children: <Widget>[
              //               Image.network(
              //                 snapshot.data!['data'][item]['blog_images'] !=
              //                         null
              //                     ? snapshot.data!['data'][item]['blog_images']
              //                         [0]['blogi_path_name']
              //                     : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
              //                 fit: BoxFit.cover,
              //                 width: double.infinity,
              //               ),
              //               Center(
              //                 child: Text(
              //                   // '${titles[_currentIndex]}',
              //                   '${snapshot.data!['data'][item]['blog_name']}',
              //                   style: TextStyle(
              //                     fontSize: 24.0,
              //                     fontWeight: FontWeight.bold,
              //                     backgroundColor: Colors.black45,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // );
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
            'รางวัล',
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
        ),
      );
    }

    Widget titleMenus1() {
      return Container(
        margin: EdgeInsets.only(
          top: 0,
          left: 20,
        ),
        child: Text(
          'รางวัลทั้งหมด',
          style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.black,
          title: Center(child: const Text('รางวัล')),
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              // titleMenus(),
              award_pageSlide(context),
              titleMenus1(),
              award_page(context),

              //  sss2(context),
            ],
          ),
        ));
  }
}

    // Widget sss2(BuildContext context) {
    //   return Container(
    //     height: 700,
    //     child: Container(
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [Colors.pinkAccent, Colors.orangeAccent],
    //               begin: Alignment.topRight,
    //               end: Alignment.bottomLeft)),
    //       child: isLoading == true
    //           ? Center(
    //               child: CircularProgressIndicator(),
    //             )
    //           : ListView.separated(
    //               // scrollDirection: Axis.horizontal,
    //               itemBuilder: (context, index) {
    //                 var app_image = data[index].blogImages?[0] != null
    //                     ? data[index].blogImages![0].blogiPathName
    //                     : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';
    //                 return Center(
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       InkWell(
    //                         onTap: () {
    //                           Navigator.pushNamed(context, '/productshop_page',
    //                               arguments: {
    //                                 /*   'id': data[index].id,
    //                             'detail': data[index].detail,
    //                             'picture': data[index].picture,
    //                             'view': data[index].view,*/
    //                               });
    //                         },
    //                         child: Container(
    //                           margin: EdgeInsets.only(top: 20, bottom: 0),
    //                           child: Row(
    //                             children: [
    //                               SizedBox(width: defaultMargin),
    //                               Container(
    //                                 height: 400,
    //                                 width: 365,
    //                                 decoration: BoxDecoration(
    //                                     color: secondaryTextColor,
    //                                     borderRadius: BorderRadius.circular(
    //                                       24,
    //                                     ),
    //                                     boxShadow: [
    //                                       BoxShadow(
    //                                           color:
    //                                               Colors.grey.withOpacity(0.5),
    //                                           offset: Offset(2, 2),
    //                                           blurRadius: 7,
    //                                           spreadRadius: 1.0),
    //                                       BoxShadow(
    //                                           color:
    //                                               Colors.grey.withOpacity(0.5),
    //                                           offset: Offset(2, 4),
    //                                           blurRadius: 7.0,
    //                                           spreadRadius: 1.0),
    //                                     ]),
    //                                 child: Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Column(
    //                                       children: [
    //                                         Padding(
    //                                           padding: EdgeInsets.all(10.0),
    //                                           child: Container(
    //                                               child: Image.network(
    //                                             app_image!,
    //                                             width: 220,
    //                                           )),
    //                                         ),
    //                                         SizedBox(height: 15),
    //                                         Container(
    //                                           width: 340,
    //                                           color: Colors.grey[200],
    //                                           height: 100,
    //                                           child: Column(
    //                                             children: [
    //                                               SizedBox(height: 15),
    //                                               Container(
    //                                                 child: Text(
    //                                                   'ข่าว: ${data[index].blogName}',
    //                                                   style: primaryTextStyle
    //                                                       .copyWith(
    //                                                           fontSize: 18,
    //                                                           fontWeight:
    //                                                               medium),
    //                                                 ),
    //                                               ),
    //                                               SizedBox(height: 15),
    //                                               Text(
    //                                                 'ราคาสินค้า : ${data[index].blogDetail} บาท',
    //                                                 style: primaryTextStyle
    //                                                     .copyWith(
    //                                                         fontSize: 20,
    //                                                         fontWeight: medium),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         )
    //                                       ],
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //               separatorBuilder: (context, index) => Divider(),
    //               itemCount: data.length),
    //     ),
    //   );
    // }

    // Widget ssss2(BuildContext context) {
    //   return Container(
    //     height: 500,
    //     margin: EdgeInsets.only(top: 10, bottom: 10),
    //     child: isLoading == true
    //         ? Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         : ListView.builder(
    //             // scrollDirection: Axis.horizontal,
    //             itemBuilder: (context, index) {
    //               var app_image = data[index].blogImages?[0] != null
    //                   ? data[index].blogImages![0].blogiPathName
    //                   : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

    //               //  var   app_image = data[index].productImage![0].productiPathName ??
    //               //         'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

    //               return Center(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     InkWell(
    //                       onTap: () {
    //                         Navigator.pushNamed(context, '/productshop_page',
    //                             arguments: {
    //                               /*   'id': data[index].id,
    //                           'detail': data[index].detail,
    //                           'picture': data[index].picture,
    //                           'view': data[index].view,*/
    //                             });
    //                       },
    //                       child: Container(
    //                         margin: EdgeInsets.only(top: 20, bottom: 0),
    //                         child: Row(
    //                           children: [
    //                             SizedBox(width: defaultMargin),
    //                             Container(
    //                               height: 400,
    //                               width: 365,
    //                               decoration: BoxDecoration(
    //                                   color: secondaryTextColor,
    //                                   borderRadius: BorderRadius.circular(
    //                                     24,
    //                                   ),
    //                                   boxShadow: [
    //                                     BoxShadow(
    //                                         color: Colors.grey.withOpacity(0.5),
    //                                         offset: Offset(2, 2),
    //                                         blurRadius: 7,
    //                                         spreadRadius: 1.0),
    //                                     BoxShadow(
    //                                         color: Colors.grey.withOpacity(0.5),
    //                                         offset: Offset(2, 4),
    //                                         blurRadius: 7.0,
    //                                         spreadRadius: 1.0),
    //                                   ]),
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   Column(
    //                                     children: [
    //                                       Padding(
    //                                         padding: EdgeInsets.all(10.0),
    //                                         child: Container(
    //                                             child: Image.network(
    //                                           app_image,
    //                                           width: 220,
    //                                         )),
    //                                       ),
    //                                       SizedBox(height: 15),
    //                                       Container(
    //                                         width: 340,
    //                                         color: Colors.grey[200],
    //                                         height: 100,
    //                                         child: Column(
    //                                           children: [
    //                                             SizedBox(height: 15),
    //                                             Container(
    //                                               child: Text(
    //                                                 'ชื่อสินค้า: ',
    //                                                 style: primaryTextStyle
    //                                                     .copyWith(
    //                                                         fontSize: 18,
    //                                                         fontWeight: medium),
    //                                               ),
    //                                             ),
    //                                             SizedBox(height: 15),
    //                                             Text(
    //                                               'ราคาสินค้า : ${data[index].blogName} บาท',
    //                                               style:
    //                                                   primaryTextStyle.copyWith(
    //                                                       fontSize: 20,
    //                                                       fontWeight: medium),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       )
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //             // separatorBuilder: (context, index) => Divider(),
    //             itemCount: data.length),
    //   );
    // }


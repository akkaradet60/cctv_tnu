import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/models/blogs/blogs.dart';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class message_page extends StatefulWidget {
  message_page({Key? key}) : super(key: key);

  @override
  _message_pageState createState() => _message_pageState();
}

class _message_pageState extends State<message_page> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

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
      print(imgSlide);
      // print(imgSlide['data'].length);
      return imgSlide;
    } else {
      throw Exception('$response.statusCode');
    }
  }

  late List<String> titles = [
    ' 1 ',
    ' 2 ',
    ' 3 ',
    ' 4 ',
    ' 5',
  ];

  /* void _incrementCounter() {
    setState(() {
      _counter++;
      _product = _product + _product1;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Widget ssss(BuildContext context) {
      return Padding(
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
                              color: ThemeBc.green05,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
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
                                color: ThemeBc.textwhite,
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
                        onTap: () {
                          Navigator.pushNamed(context, '/messagemdetail_page',
                              arguments: {
                                'blog_images': snapshot.data!['data'][item]
                                                ['blog_images'][0]
                                            ['blogi_path_name'] !=
                                        null
                                    ? Global.domainImage +
                                        snapshot.data!['data'][item]
                                                ['blog_images'][0]
                                            ['blogi_path_name']
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

                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          child: ListView(
                            children: [
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 250,
                                    child: Image.network(
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
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 135),
                                      Container(
                                        color: ThemeBc.black54,
                                        width: 370,
                                        height: 100,
                                        child: ListView(
                                          children: [
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                // '${titles[_currentIndex]}',
                                                '  ${snapshot.data!['data'][item]['blog_name']}',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc.textwhite,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                  ),
                                                ),
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
                  );
                }

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
        ),
      );
    }

    Widget ss1(BuildContext context) {
      return Container(
        color: ThemeBc.white,
        margin: EdgeInsets.only(top: 10, bottom: 0),
        width: 500,
        height: 500,
        child: FutureBuilder<Map<String, dynamic>>(
          future: getDataSlide(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!['data'].length,
                itemBuilder: (context, int index) {
                  if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeBc.green05,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
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
                                  color: ThemeBc.textwhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    width: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/messagemdetail_page',
                                  arguments: {
                                    'blog_images': snapshot.data!['data'][index]
                                                    ['blog_images'][0]
                                                ['blogi_path_name'] !=
                                            null
                                        ? Global.domainImage +
                                            snapshot.data!['data'][index]
                                                    ['blog_images'][0]
                                                ['blogi_path_name']
                                        : '${Global.networkImage}',
                                    'blog_name': snapshot.data!['data'][index]
                                        ['blog_name'],
                                    'blog_detail': snapshot.data!['data'][index]
                                        ['blog_detail']

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
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  child: Container(
                                                      height: 220,
                                                      child: Image.network(
                                                        snapshot.data!['data']
                                                                            [index]
                                                                        ['blog_images'][0]
                                                                    [
                                                                    'blogi_path_name'] !=
                                                                null
                                                            ? Global.domainImage +
                                                                snapshot.data!['data']
                                                                            [index]
                                                                        [
                                                                        'blog_images'][0]
                                                                    [
                                                                    'blogi_path_name']
                                                            : '${Global.networkImage}',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              width: 340,
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
                                                        '${snapshot.data!['data'][index]['blog_name']}',
                                                        style:
                                                            GoogleFonts.sarabun(
                                                          textStyle: TextStyle(
                                                            color: ThemeBc
                                                                .textblack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        // style: primaryTextStyle
                                                        //     .copyWith(
                                                        //         fontSize: 16,
                                                        //         fontWeight:
                                                        //             medium),
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
                                                        '${snapshot.data!['data'][index]['blog_detail']}',
                                                        style:
                                                            GoogleFonts.sarabun(
                                                          textStyle: TextStyle(
                                                            color: ThemeBc
                                                                .textblack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15,
                                                          ),
                                                        ),
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
            'ข่าวสาร',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              // backgroundColor: Colors.black45,
              color: Colors.white,
            ),
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
          'ข่าวทั้งหมด',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            // backgroundColor: Colors.black45,
            color: ThemeBc.textblack,
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.green05,
          title: Column(
            children: [
              Center(
                  child: LocaleText(
                'ข่าวสาร',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.textwhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: ThemeBc.green05,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeBc.white, ThemeBc.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              // titleMenus(),
              ssss(context),
              Row(
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
                          ? const Color.fromRGBO(0, 0, 0, 0.8)
                          : const Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),

              titleMenus1(),
              ss1(context),

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
    //               colors: [Colors.white, Colors.white],
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


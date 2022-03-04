import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class composedetail_page extends StatefulWidget {
  composedetail_page({Key? key}) : super(key: key);

  @override
  State<composedetail_page> createState() => _composedetail_page();
}

class _composedetail_page extends State<composedetail_page> {
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
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Center(
              child: Text(
            '${datail_blogpose['emt_name'] ?? '-'}',
            style: GoogleFonts.sarabun(
              textStyle: TextStyle(
                color: ThemeBc.textwhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: ThemeBc.background,
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
                  end: Alignment.bottomLeft)),
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
                                            color: ThemeBc.textblack,
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
                                    child: CircularProgressIndicator());
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
                                                    color: ThemeBc.textblack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${datail_blogpose['em_owner']}',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc.textblack,
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
                                                    color: ThemeBc.textblack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${datail_blogpose['emt_name'] ?? '-'}',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc.textblack,
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
                                                color: ThemeBc.textblack,
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
                                                color: ThemeBc.textblack,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'จุดเกิดเหตุ : ${datail_blogpose['em_lat']} ${datail_blogpose['em_lng']}',
                                            style: GoogleFonts.sarabun(
                                              textStyle: TextStyle(
                                                color: ThemeBc.textblack,
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



// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class composedetail_page extends StatefulWidget {
//   composedetail_page({Key? key}) : super(key: key);

//   @override
//   State<composedetail_page> createState() => _composedetail_page();
// }

// class _composedetail_page extends State<composedetail_page> {
//   var datail_blogpose;
//   bool isLoading = true;
//   late Map<String, dynamic> imgSlide;

//   int _currentIndex = 0;
//   Future<Map<String, dynamic>> getDataSlide() async {
//     var url = (Global.urlWeb +
//         'api/app/emergency/restful/?em_app_id=${Global.app_id}&em_category=0&em_user_id=${Global.user_id}');
//     var response = await http.get(Uri.parse(url), headers: {
//       'Authorization':
//           'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//     });

//     if (response.statusCode == 200) {
//       imgSlide = json.decode(response.body);

//       // print(imgSlide['data'].length);
//       return imgSlide;
//     } else {
//       throw Exception('$response.statusCode');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     datail_blogpose = ModalRoute.of(context)!.settings.arguments;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: ThemeBc.white, //change your color here
//           ),
//           
//           foregroundColor: ThemeBc.white,
//           backgroundColor: ThemeBc.background,
//           title: Column(
//             children: [
//               Center(child: Text('${datail_blogpose['em_type']}')),
//             ],
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.refresh,color: ThemeBc.background,),
//               tooltip: 'Show Snackbar',
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('เราเทศบาลตำบลพระลับ')));
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [ThemeBc.white, ThemeBc.white],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft)),
//           height: 1000,
//           width: 1000,
//           child: Container(
//             color: ThemeBc.background,
//             child: ListView(
//               children: [
//                 Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [Colors.white, Colors.white],
//                                 begin: Alignment.topRight,
//                                 end: Alignment.bottomLeft)),
//                         height: 300,
//                         width: 1000,
//                         child: FutureBuilder<Map<String, dynamic>>(
//                           future: getDataSlide(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               // return ListView.separated(
//                               //     itemBuilder: (context, index) {
//                               // return Text('3232');
//                               return CarouselSlider.builder(
//                                 itemCount: snapshot.data!['data'].length,
//                                 options: CarouselOptions(
//                                   autoPlay: true,
//                                   enlargeCenterPage: true,
//                                   viewportFraction: 0.9,
//                                   aspectRatio: 2.0,
//                                   initialPage: 2,
//                                   onPageChanged: (index, reason) {
//                                     setState(
//                                       () {
//                                         _currentIndex = index;
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 itemBuilder: (BuildContext context, int item,
//                                         int pageViewIndex) =>

//                                     // Text('${snapshot.data!['data'][item]['blog_id']}');
//                                     //     Container(
//                                     //   child: Center(child: Text(item.toString())),
//                                     //   color: Colors.green,
//                                     // ),
//                                     Card(
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(8.0),
//                                     ),
//                                     child: Stack(
//                                       children: <Widget>[
//                                         Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Image.network(
//                                             datail_blogpose['em_images'],
//                                             fit: BoxFit.cover,
//                                             width: double.infinity,
//                                           ),
//                                         ),
//                                         // Center(
//                                         //   child: Text(
//                                         //     // '${titles[_currentIndex]}',
//                                         //     '${snapshot.data!['data'][item]['blog_name']}',
//                                         //     style: TextStyle(
//                                         //       fontSize: 24.0,
//                                         //       fontWeight: FontWeight.bold,
//                                         //       backgroundColor: Colors.black45,
//                                         //       color: Colors.white,
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 //   ListView(
//                                 // children: [
//                                 //   ClipRRect(
//                                 //     borderRadius: BorderRadius.all(
//                                 //       Radius.circular(8.0),
//                                 //     ),
//                                 //     child: Stack(
//                                 //       children: <Widget>[
//                                 //         Image.network(
//                                 //           datail_blogpose['em_images'],
//                                 //           fit: BoxFit.cover,
//                                 //           width: double.infinity,
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ],

//                                 //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
//                                 // boxShape: NeumorphicBoxShape.circle(),

//                                 // shadowColor: Colors.redAccent,
//                                 // shape: RoundedRectangleBorder(
//                                 //blog_images//     // borderRadius: BorderRadius.circular(30.0),
//                                 //     ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Center(
//                                   child: Text(
//                                       'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
//                             }

//                             return Center(child: CircularProgressIndicator());
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Container(
//                 //   child: Column(
//                 //     children: [
//                 //       Container(
//                 //         height: 300,
//                 //         child: Card(
//                 //           child:
//                 //               Image.network('${datail_blogpose['em_images']}'),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 Container(
//                   height: 500,
//                   color: ThemeBc.background,
//                   child: ListView(
//                     children: [
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: ThemeBc.white,
//                                   borderRadius: BorderRadius.circular(
//                                     20,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         offset: Offset(2, 2),
//                                         blurRadius: 7,
//                                         spreadRadius: 1.0),
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.5),
//                                         offset: Offset(2, 4),
//                                         blurRadius: 7.0,
//                                         spreadRadius: 1.0),
//                                   ]),
//                               width: 390,
//                               height: 280,
//                               child: ListView(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           'ชื่อคนร้องเรียน : ${datail_blogpose['em_owner']}',
//                                           style: TextStyle(
//                                             fontSize: 15.0,
//                                             fontWeight: FontWeight.bold,
//                                             // backgroundColor: Colors.black45,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         'ประเภทที่ร้องเรียน : ${datail_blogpose['em_type']}',
//                                         style: TextStyle(
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.bold,
//                                           // backgroundColor: Colors.black45,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Container(
//                                         height: 200,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: ListView(
//                                             children: [
//                                               Text(
//                                                 'เนื้อหาที่ได้ร้องเรียน : ${datail_blogpose['em_detail']}',
//                                                 style: TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   // backgroundColor: Colors.black45,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 'เบอร์โทรติดต่อที่คุณแจ้ง : ${datail_blogpose['em_phone']}',
//                                                 style: TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   // backgroundColor: Colors.black45,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 'จุดเกิดเหตุ : ${datail_blogpose['em_lat']} ${datail_blogpose['em_lng']}',
//                                                 style: TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   // backgroundColor: Colors.black45,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
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
//         ));
//   }
// }

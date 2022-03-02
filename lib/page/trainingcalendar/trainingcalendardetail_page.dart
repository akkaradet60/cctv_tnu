import 'package:carousel_slider/carousel_slider.dart';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class trainingcalendardetail_page extends StatefulWidget {
  trainingcalendardetail_page({Key? key}) : super(key: key);

  @override
  _trainingcalendardetail_page createState() => _trainingcalendardetail_page();
}

class _trainingcalendardetail_page extends State<trainingcalendardetail_page> {
  var trainingcalendardetail;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url =
        ('https://www.bc-official.com/api/app_nt/api/app/train/restful/?train_app_id=1');
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
  // Future<void> getData() async {
  //   var url =
  //       ('https://www.bc-official.com/api/app_nt/api/app/train/restful/?train_id=8&train_app_id=1');
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   // print(json.decode(response.body));

  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final Trainingcalendar trainingcalendar =
  //         Trainingcalendar.fromJson(json.decode(response.body));
  //     print(trainingcalendar.data);
  //     setState(() {
  //       data = trainingcalendar.data;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error 400');
  //   }
  // }

  // Future<void> getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   Map<String, dynamic> appToken =
  //       json.decode(prefs.getString('token').toString());
  //   // print(appToken['access_token']);

  //   setState(() {
  //     Global.token = appToken['access_token'];
  //   });

  //   var newProfile = json.decode(prefs.getString('profile').toString());
  //   var newApplication = json.decode(prefs.getString('application').toString());
  //   // print(newProfile);
  //   // print(newApplication);
  //   //call redux action
  //   /* final store = StoreProvider.of<AppState>(context);
  //   store.dispatch(updateProfileAction(newProfile));
  //   store.dispatch(updateApplicationAction(newApplication));*/
  // }

  @override
  void initState() {
    super.initState();
    // getData();
    // getProfile();
  }

  @override
  Widget build(BuildContext context) {
    trainingcalendardetail = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: ThemeBc.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(
            child: Text(
          'การฝึกอบรม ${trainingcalendardetail['trainName']}',
          style: GoogleFonts.sarabun(
            textStyle: TextStyle(
              color: ThemeBc.textwhite,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        )),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('เราเทศบาลตำบลพระลับ')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 5),

              // sss(context),
              hotlineee(context)
              //  ss2(context),
              //  ssto(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget hotlineee(BuildContext context) {
    trainingcalendardetail = ModalRoute.of(context)!.settings.arguments;
    return Container(
      height: 600,
      width: 1000,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.white, ThemeBc.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Container(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
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
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                                trainingcalendardetail[
                                                    'trainImages'],
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
                            ;
                            // return ListView.separated(
                            //     itemBuilder: (context, index) {
                            // return Text('3232');

                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      ),
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
                          width: 390,
                          height: 280,
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${trainingcalendardetail['trainName']}',
                                  style: GoogleFonts.sarabun(
                                    textStyle: TextStyle(
                                      color: ThemeBc.textblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${trainingcalendardetail['trainDetail']}',
                                  style: GoogleFonts.sarabun(
                                    textStyle: TextStyle(
                                      color: ThemeBc.textblack,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
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
    );
  }

  // Widget sss(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: defaultMargin),
  //     margin: EdgeInsets.only(top: 0, bottom: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CustomButton(
  //           title: 'ทดลองใช้ในฐานะผู้เยี่ยมชม',
  //           onPressed: () => Navigator.pushNamed(context, '/hotlinee_page1'),
  //           colorButton: buttonGreyColor,
  //           textStyle:
  //               secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget ss2(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //             colors: [Colors.white, Colors.white],
  //             begin: Alignment.topRight,
  //             end: Alignment.bottomLeft)),
  //     height: 500,
  //     child: ListView.builder(itemBuilder: (context, index) {
  //       return Container(child: Text('${data[1].hotlineId}'));
  //     }),
  //   );
  // }

  // Widget ssto(BuildContext context) {
  //   return Container(
  //     height: 400,
  //     child: Container(
  //       child: ListView.builder(
  //           // scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             return Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.pushNamed(context, '/productshop_page',
  //                           arguments: {
  //                             /*   'id': data[index].id,
  //                               'detail': data[index].detail,
  //                               'picture': data[index].picture,
  //                               'view': data[index].view,*/
  //                           });
  //                     },
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: 20, bottom: 0),
  //                       child: Row(
  //                         children: [
  //                           SizedBox(width: defaultMargin),
  //                           Container(
  //                             height: 400,
  //                             width: 365,
  //                             decoration: BoxDecoration(
  //                                 color: secondaryTextColor,
  //                                 borderRadius: BorderRadius.circular(
  //                                   24,
  //                                 ),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                       color: Colors.grey.withOpacity(0.5),
  //                                       offset: Offset(2, 2),
  //                                       blurRadius: 7,
  //                                       spreadRadius: 1.0),
  //                                   BoxShadow(
  //                                       color: Colors.grey.withOpacity(0.5),
  //                                       offset: Offset(2, 4),
  //                                       blurRadius: 7.0,
  //                                       spreadRadius: 1.0),
  //                                 ]),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Column(
  //                                   children: [
  //                                     ClipRRect(
  //                                       borderRadius: const BorderRadius.all(
  //                                         Radius.circular(3.0),
  //                                       ),
  //                                       child: Stack(
  //                                         children: <Widget>[],
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 15),
  //                                     Container(
  //                                       width: 340,
  //                                       color: Colors.grey[200],
  //                                       height: 100,
  //                                       child: Column(
  //                                         children: [
  //                                           SizedBox(height: 15),
  //                                           Container(
  //                                             child: Text(
  //                                               'ชื่อสินค้า: ',
  //                                               style:
  //                                                   primaryTextStyle.copyWith(
  //                                                       fontSize: 18,
  //                                                       fontWeight: medium),
  //                                             ),
  //                                           ),
  //                                           SizedBox(height: 15),
  //                                           Text(
  //                                             'ราคาสินค้า : บาท',
  //                                             style: primaryTextStyle.copyWith(
  //                                                 fontSize: 20,
  //                                                 fontWeight: medium),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //           // separatorBuilder: (context, index) => Divider(),
  //           itemCount: data.length),
  //     ),
  //   );
  // }
}

// Widget buildbutton() {
//   final number1 = '199';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ตำตรวจ',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number1),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.white,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number1);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildbutton1() {
//   final number = '043-245265';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ศูตรขอนแก่น',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.white,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildbutton2() {
//   final number = '083-6842051';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ตั้นคนโสดน่าาา',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.white,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class hotlinee_page extends StatefulWidget {
  hotlinee_page({Key? key}) : super(key: key);

  @override
  _hotlinee_pageState createState() => _hotlinee_pageState();
}

class _hotlinee_pageState extends State<hotlinee_page> {
  late Map<String, dynamic> imgSlide;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/hotline/restful/?hotline_app_id=${Global.app_id}');
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

  // List<Data> data = [];
  // bool isLoading = true;
  // var hotlinee;
  // Future<void> getData() async {
  // var url = (Global.urlWeb +
  //     'api/app/hotline/restful/?hotline_app_id=${Global.app_id}');
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   // print(json.decode(response.body));

  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final Hotlinee hotlinee = Hotlinee.fromJson(json.decode(response.body));
  //     print(hotlinee.data);
  //     setState(() {
  //       data = hotlinee.data!;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error 400');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
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
              'สายด่วน',
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
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('เราเทศบาลพระลับ')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeBc.white, ThemeBc.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              // sss(context),
              hotlineee(context),
              // bottom(context),
              //  ss2(context),
              //  ssto(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget bottom(BuildContext context) {
  //   return Container(
  //     child: Column(
  //       children: [
  //         SizedBox(height: 18),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             CustomButtonmenu(
  //               title: 'สายด่าน',
  //               onPressed: () => Navigator.pushNamed(context, '/warn'),
  //               colorButton: buttonGreyColor,
  //               textStyle: secondaryTextStyle.copyWith(
  //                   fontWeight: medium, fontSize: 16),
  //             ),
  //             SizedBox(width: 10),
  //             CustomButtonmenu(
  //               title: 'สถานที่ราชการ',
  //               onPressed: () => Navigator.pushNamed(context, '/warn'),
  //               colorButton: primaryColor,
  //               textStyle: secondaryTextStyle.copyWith(
  //                   fontWeight: medium, fontSize: 16),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  Widget hotlineee(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.white, ThemeBc.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: Column(
          children: [
            SizedBox(height: 5),
            Container(
              height: 700,
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
                    }
                    // return ListView.separated(
                    //     itemBuilder: (context, index) {
                    // return Text('3232');
                    return ListView.builder(
                      itemCount: snapshot.data!['data'].length,
                      itemBuilder: (context, index) {
                        final number =
                            '${snapshot.data!['data'][index]['hotline_phone']}';
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: secondaryTextColor,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    height: 80,
                                    child: Container(
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Container(
                                              width: 300,
                                              height: 30,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  SizedBox(height: 50),
                                                  Text(
                                                    '${snapshot.data!['data'][index]['hotline_name']} ',
                                                    style: GoogleFonts.sarabun(
                                                      textStyle: TextStyle(
                                                        color:
                                                            ThemeBc.textblack,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            subtitle: Text(number),
                                            trailing: Container(
                                              width: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons.phone,
                                                            color:
                                                                ThemeBc.black,
                                                            size: 30,
                                                          ),
                                                          tooltip:
                                                              'Show Snackbar',
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      ThemeBc
                                                                          .white,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          new BorderRadius.circular(
                                                                              10)),
                                                                  content:
                                                                      Container(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          500,
                                                                      height:
                                                                          160,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.grey[200],
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                  boxShadow: []),
                                                                              width: 500,
                                                                              height: 80,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: ListView(
                                                                                  children: [
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'ติดต่อไปที่',
                                                                                        style: GoogleFonts.sarabun(
                                                                                          textStyle: TextStyle(
                                                                                            color: ThemeBc.textblack,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontSize: 15,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Center(
                                                                                      child: Text(
                                                                                        '${snapshot.data!['data'][index]['hotline_name']} ${snapshot.data!['data'][index]['hotline_phone']} ?',
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
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              await FlutterPhoneDirectCaller.callNumber(number);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: Text(
                                                                                'ตกลง',
                                                                                style: GoogleFonts.sarabun(
                                                                                  textStyle: TextStyle(
                                                                                    color: ThemeBc.textwhite,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 15,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: ThemeBc.green05,
                                                                              onPrimary: Colors.white,
                                                                              // shadowColor: Colors.white,
                                                                              // elevation: 30,
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }),
                                                    ),
                                                    //         .callNumber(number);},
                                                    SizedBox(width: 5),
                                                    Container(
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.maps_home_work,
                                                          color: ThemeBc.black,
                                                          size: 30,
                                                        ),
                                                        tooltip:
                                                            'Show Snackbar',
                                                        onPressed: () =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/map_page',
                                                                arguments: {
                                                              'hotlineLat': snapshot
                                                                          .data![
                                                                      'data'][index]
                                                                  [
                                                                  'hotline_lat'],
                                                              'hotlineLng': snapshot
                                                                          .data![
                                                                      'data'][index]
                                                                  [
                                                                  'hotline_lng'],
                                                              'hotlineName': snapshot
                                                                          .data![
                                                                      'data'][index]
                                                                  [
                                                                  'hotline_name'],
                                                            }),
                                                      ),
                                                    ),
                                                  ],
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
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                  }

                  return Center(
                      child: SpinKitCubeGrid(
                    color: ThemeBc.green05,
                  ));
                },
              ),
            ),
          ],
        ),
        // child: isLoading == true
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : Container(
        //         child: ListView.separated(
        //             itemBuilder: (context, index) {
        //               final number = '${data[index].hotlinePhone}';
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: 80,
        //                   decoration: BoxDecoration(
        //                       color: secondaryTextColor,
        //                       borderRadius: BorderRadius.circular(
        //                         30,
        //                       ),
        //                       boxShadow: [
        //                         BoxShadow(
        //                             color: Colors.grey.withOpacity(0.5),
        //                             offset: Offset(2, 2),
        //                             blurRadius: 7,
        //                             spreadRadius: 1.0),
        //                         BoxShadow(
        //                             color: Colors.black.withOpacity(0.5),
        //                             offset: Offset(2, 4),
        //                             blurRadius: 7.0,
        //                             spreadRadius: 1.0),
        //                       ]),
        //     child: Container(
        //       child: Column(
        //         // mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           ListTile(
        //             title: Container(
        //               width: 300,
        //               height: 20,
        //               child: ListView(
        //                 scrollDirection: Axis.horizontal,
        //                 children: [
        //                   SizedBox(height: 20),
        //                   Text(
        //                     '${data[index].hotlineName}',
        //                     style: primaryTextStyle.copyWith(
        //                         fontSize: 18, fontWeight: medium),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             subtitle: Text(number),
        //             trailing: Container(
        //               width: 150,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(5.0),
        //                 child: Row(
        //                   children: [
        //                     //         .callNumber(number);},
        //                     Container(
        //                       height: 50,
        //                       child: ElevatedButton.icon(
        //                         onPressed: () async {
        //                           await FlutterPhoneDirectCaller
        //                               .callNumber(number);
        //                         },
        //                         icon: Icon(
        //                           Icons.phone,
        //                           color: Colors.pink,
        //                           size: 30,
        //                         ),
        //                         label: Text(''),
        //                         style: ElevatedButton.styleFrom(
        //                           primary: Colors.white,
        //                           elevation: 10,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius:
        //                                   BorderRadius.all(
        //                                       Radius.circular(
        //                                           20))),
        //                         ),
        //                       ),
        //                     ),
        //                     SizedBox(width: 5),
        //                     Container(
        //                       height: 50,
        //                       child: ElevatedButton.icon(
        //                         onPressed: () =>
        //                             Navigator.pushNamed(
        //                                 context, '/map_page',
        //                                 arguments: {
        //                               'hotlineLat':
        //                                   data[index].hotlineLat,
        //                               'hotlineLng':
        //                                   data[index].hotlineLng,
        //                               'hotlineName':
        //                                   data[index].hotlineName,
        //                               // 'productName':
        //                               //     data[index].productName,
        //                               // 'productPrice':
        //                               //     data[index].productPrice,
        //                               // 'productiPathName': data[index]
        //                               //         .productImage?[0]
        //                               //         .productiPathName ??
        //                               //     'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
        //                               // 'productiproductid': data[index]
        //                               //     .productImage?[0]
        //                               //     .productiProductId,

        //                               /*   'id': data[index].id,
        //                   'detail': data[index].detail,
        //                   'picture': data[index].picture,
        //                   'view': data[index].view,*/
        //                             }),
        //                         icon: Icon(
        //                           Icons.maps_home_work,
        //                           color: Colors.pink,
        //                           size: 30,
        //                         ),
        //                         label: Text(''),
        //                         style: ElevatedButton.styleFrom(
        //                           primary: Colors.white,
        //                           elevation: 10,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius:
        //                                   BorderRadius.all(
        //                                       Radius.circular(
        //                                           20))),
        //                         ),
        //                       ),
        //                     ),

        //                     // child: TextButton(
        //                     //   style: TextButton.styleFrom(
        //                     //       backgroundColor:
        //                     //           Colors.white,
        //                     //       padding:
        //                     //           EdgeInsets.symmetric(
        //                     //               horizontal: 0,
        //                     //               vertical: 0),
        //                     //       shape:
        //                     //           RoundedRectangleBorder(
        //                     //               side: BorderSide(
        //                     //                   color: Colors
        //                     //                       .white))),
        //                     //   child: Text(
        //                     //     'call',
        //                     //   ),
        //                     // onPressed: () async {
        //                     // await FlutterPhoneDirectCaller
        //                     //       .callNumber(number);
        //                     // },
        //                     // ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
        //             },
        //             separatorBuilder: (context, index) => Divider(),
        //             itemCount: data.length),
        //       ),
      ),
    );
  }

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

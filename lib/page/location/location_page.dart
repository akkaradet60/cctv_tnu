import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:cctv_tun/widgets/custom_buttonmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cctv_tun/widgets/custom_button.dart';

class location_page extends StatefulWidget {
  location_page({Key? key}) : super(key: key);

  @override
  _location_page createState() => _location_page();
}

class _location_page extends State<location_page> {
  late Map<String, dynamic> imgSlide;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/travel/restful/?travel_app_id=1&travel_cat=1');
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
  //   var url = (Global.urlWeb +
  //       'api/app/travel/restful/?travel_app_id=1&travel_cat=1');
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   // print(json.decode(response.body));

  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final Location hotlinee = Location.fromJson(json.decode(response.body));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(child: Text('สถานที่ราชการ')),
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeBc.orange, ThemeBc.pinkAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              SizedBox(height: 5),

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

  Widget hotlineee(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 0),
      width: 1000,
      height: 1000,
      child: FutureBuilder<Map<String, dynamic>>(
        future: getDataSlide(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!['data'].length,
              itemBuilder: (context, index) {
                var day01 =
                    snapshot.data!['data'][index]['travel_open_everyday'] ?? 0;
                var detail = '';
                var travel_start_time =
                    snapshot.data!['data'][index]['travel_start_time'] ?? 0.00;

                var travel_end_time =
                    snapshot.data!['data'][index]['travel_end_time'] ?? 0.00;

                var travelt_mon =
                    snapshot.data!['data'][index]['travelt_mon'] ?? '0';
                var travelt_mon_start =
                    snapshot.data!['data'][index]['travelt_mon_start'] ?? '0';
                var travelt_mon_end =
                    snapshot.data!['data'][index]['travelt_mon_end'] ?? '0';

                var travelt_tues =
                    snapshot.data!['data'][index]['travelt_tues'] ?? '0';
                var travelt_tues_start =
                    snapshot.data!['data'][index]['travelt_tues_start'] ?? '0';
                var travelt_tues_end =
                    snapshot.data!['data'][index]['travelt_tues_end'] ?? '0';
                var travelt_wednes =
                    snapshot.data!['data'][index]['travelt_wednes'] ?? '0';
                var travelt_wednes_start = snapshot.data!['data'][index]
                        ['travelt_wednes_start'] ??
                    '0';
                var travelt_wednes_end =
                    snapshot.data!['data'][index]['travelt_wednes_end'] ?? '0';

                var travelt_thurs =
                    snapshot.data!['data'][index]['travelt_thurs'] ?? '0';
                var travelt_thurs_start =
                    snapshot.data!['data'][index]['travelt_thurs_start'] ?? '0';
                var travelt_thurs_end =
                    snapshot.data!['data'][index]['travelt_thurs_end'] ?? '0';

                var travelt_fri =
                    snapshot.data!['data'][index]['travelt_fri'] ?? '0';
                var travelt_fri_start =
                    snapshot.data!['data'][index]['travelt_fri'] ?? '0';
                var travelt_fri_end =
                    snapshot.data!['data'][index]['travelt_fri'] ?? '0';

                var travelt_sun =
                    snapshot.data!['data'][index]['travelt_sun'] ?? '0';
                var travelt_sun_start =
                    snapshot.data!['data'][index]['travelt_sun_start'] ?? '0';
                var travelt_sun_end =
                    snapshot.data!['data'][index]['travelt_sun_end'] ?? '0';

                var travelt_satur =
                    snapshot.data!['data'][index]['travelt_satur'] ?? '0';
                var travelt_satur_satur =
                    snapshot.data!['data'][index]['travelt_satur'] ?? '0';
                var travelt_satur_end =
                    snapshot.data!['data'][index]['travelt_satur'] ?? '0';

                if (travelt_mon == 2 || travelt_mon == '2') {
                  travelt_mon =
                      'วันจันทร์ เปิดตั้งแต่เวลา $travelt_mon_start - $travelt_mon_end ';
                } else {
                  travelt_mon = 'วันจันทร์ปิด';
                }
                if (travelt_tues == '2' || travelt_tues == 2) {
                  travelt_tues =
                      'วันอังคาร เปิดตั้งแต่เวลา $travelt_tues_start - $travelt_tues_end ';
                } else {
                  travelt_tues = 'วันอังคารปิด';
                }
                if (travelt_wednes == '2' || travelt_wednes == 2) {
                  travelt_wednes =
                      'วันพุธ เปิดตั้งแต่เวลา $travelt_wednes_start - $travelt_wednes_end ';
                } else {
                  travelt_wednes = 'วันพุธปิด';
                }
                if (travelt_thurs == '2' || travelt_thurs == 2) {
                  travelt_thurs =
                      'วันพฤหัสบดี เปิดตั้งแต่เวลา $travelt_thurs_start - $travelt_thurs_end ';
                } else {
                  travelt_thurs = 'วันพฤหัสบดีปิด';
                }
                if (travelt_fri == '2' || travelt_fri == 2) {
                  travelt_fri =
                      'วันศุกร์ เปิดตั้งแต่เวลา $travelt_sun_start - $travelt_sun_end ';
                } else {
                  travelt_fri = 'วันศุกร์ปิด';
                }
                if (travelt_sun == '2' || travelt_sun == 2) {
                  travelt_sun =
                      'วันเสาร์ เปิดตั้งแต่เวลา $travelt_fri_start - $travelt_fri_end ';
                } else {
                  travelt_sun = 'วันเสาร์ปิด';
                }
                if (travelt_satur == '2' || travelt_satur == 2) {
                  travelt_satur =
                      'วันอาทิตย์ เปิดตั้งแต่เวลา $travelt_fri_start - $travelt_fri_end ';
                } else {
                  travelt_satur = 'วันอาทิตย์ปิด';
                }

                if (day01 == '1') {
                  detail =
                      'เปิดทุกวัน \nตั้งแต่เวลา $travel_start_time - $travel_end_time';
                } else {
                  detail =
                      'เปิดวัน \n$travelt_mon  \n$travelt_tues  \n$travelt_wednes  \n$travelt_thurs \n$travelt_fri \n$travelt_sun \n$travelt_satur';
                }

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryTextColor,
                                borderRadius: BorderRadius.circular(
                                  30,
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
                            height: 80,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        '${snapshot.data!['data'][index]['travel_name']}',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 18, fontWeight: medium),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        children: [
                                          //         .callNumber(number);},

                                          SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              height: 50,
                                              child: ElevatedButton.icon(
                                                onPressed: () =>
                                                    Navigator.pushNamed(context,
                                                        '/maplocation_page',
                                                        arguments: {
                                                      'detail': detail,
                                                      'travelLat': snapshot
                                                              .data!['data']
                                                          [index]['travel_lat'],
                                                      'travelLng': snapshot
                                                              .data!['data']
                                                          [index]['travel_lng'],
                                                      'travelName':
                                                          snapshot.data!['data']
                                                                  [index]
                                                              ['travel_name'],
                                                      'travelDetail':
                                                          snapshot.data!['data']
                                                                  [index]
                                                              ['travel_detail'],
                                                      // 'productName':
                                                      //     data[index].productName,
                                                      // 'productPrice':
                                                      //     data[index].productPrice,
                                                      // 'productiPathName': data[index]
                                                      //         .productImage?[0]
                                                      //         .productiPathName ??
                                                      //     'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
                                                      // 'productiproductid': data[index]
                                                      //     .productImage?[0]
                                                      //     .productiProductId,

                                                      /*   'id': data[index].id,
                                            'detail': data[index].detail,
                                            'picture': data[index].picture,
                                            'view': data[index].view,*/
                                                    }),
                                                icon: Icon(
                                                  Icons.maps_home_work,
                                                  color: ThemeBc.white,
                                                  size: 30,
                                                ),
                                                label: Text(''),
                                                style: ElevatedButton.styleFrom(
                                                  primary: ThemeBc.background,
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // child: TextButton(
                                          //   style: TextButton.styleFrom(
                                          //       backgroundColor:
                                          //           Colors.orange,
                                          //       padding:
                                          //           EdgeInsets.symmetric(
                                          //               horizontal: 0,
                                          //               vertical: 0),
                                          //       shape:
                                          //           RoundedRectangleBorder(
                                          //               side: BorderSide(
                                          //                   color: Colors
                                          //                       .orange))),
                                          //   child: Text(
                                          //     'call',
                                          //   ),
                                          // onPressed: () async {
                                          // await FlutterPhoneDirectCaller
                                          //       .callNumber(number);
                                          // },
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
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

  // Widget hotlineee(BuildContext context) {
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
  //           : Container(
  //               height: 1000,
  //               child: ListView.separated(
  //                   itemBuilder: (context, index) {
  //                     return Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(5.0),
  //                         child: Container(
  //                           child: Column(
  //                             // mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Container(
  //                                 height: 80,
  //                                 child: Card(
  //                                   child: Column(
  //                                     children: [
  //                                       ListTile(
  //                                         title: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             SizedBox(height: 10),
  //                                             Text(
  //                                               '${data[index].travelName}',
  //                                               style:
  //                                                   primaryTextStyle.copyWith(
  //                                                       fontSize: 18,
  //                                                       fontWeight: medium),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         trailing: Container(
  //                                           width: 80,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(0.0),
  //                                             child: Row(
  //                                               children: [
  //                                                 //         .callNumber(number);},

  //                                                 SizedBox(width: 5),
  //                                                 Padding(
  //                                                   padding:
  //                                                       const EdgeInsets.all(3),
  //                                                   child: Container(
  //                                                     height: 50,
  //                                                     child:
  //                                                         ElevatedButton.icon(
  //                                                       onPressed: () =>
  //                                                           Navigator.pushNamed(
  //                                                               context,
  //                                                               '/maplocation_page',
  //                                                               arguments: {
  //                                                             'travelLat': data[
  //                                                                     index]
  //                                                                 .travelLat,
  //                                                             'travelLng': data[
  //                                                                     index]
  //                                                                 .travelLng,
  //                                                             'travelName': data[
  //                                                                     index]
  //                                                                 .travelName,
  //                                                             'travelDetail': data[
  //                                                                     index]
  //                                                                 .travelDetail,
  //                                                             // 'productName':
  //                                                             //     data[index].productName,
  //                                                             // 'productPrice':
  //                                                             //     data[index].productPrice,
  //                                                             // 'productiPathName': data[index]
  //                                                             //         .productImage?[0]
  //                                                             //         .productiPathName ??
  //                                                             //     'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
  //                                                             // 'productiproductid': data[index]
  //                                                             //     .productImage?[0]
  //                                                             //     .productiProductId,

  //                                                             /*   'id': data[index].id,
  //                                           'detail': data[index].detail,
  //                                           'picture': data[index].picture,
  //                                           'view': data[index].view,*/
  //                                                           }),
  //                                                       icon: Icon(
  //                                                         Icons.maps_home_work,
  //                                                         color: Colors.pink,
  //                                                         size: 30,
  //                                                       ),
  //                                                       label: Text(''),
  //                                                       style: ElevatedButton
  //                                                           .styleFrom(
  //                                                         primary:
  //                                                             Colors.orange,
  //                                                         elevation: 10,
  //                                                         shape: RoundedRectangleBorder(
  //                                                             borderRadius: BorderRadius
  //                                                                 .all(Radius
  //                                                                     .circular(
  //                                                                         20))),
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                 ),

  //                                                 // child: TextButton(
  //                                                 //   style: TextButton.styleFrom(
  //                                                 //       backgroundColor:
  //                                                 //           Colors.orange,
  //                                                 //       padding:
  //                                                 //           EdgeInsets.symmetric(
  //                                                 //               horizontal: 0,
  //                                                 //               vertical: 0),
  //                                                 //       shape:
  //                                                 //           RoundedRectangleBorder(
  //                                                 //               side: BorderSide(
  //                                                 //                   color: Colors
  //                                                 //                       .orange))),
  //                                                 //   child: Text(
  //                                                 //     'call',
  //                                                 //   ),
  //                                                 // onPressed: () async {
  //                                                 // await FlutterPhoneDirectCaller
  //                                                 //       .callNumber(number);
  //                                                 // },
  //                                                 // ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                   separatorBuilder: (context, index) => Divider(),
  //                   itemCount: data.length),
  //             ),
  //     ),
  //   );
  // }

  // Widget ss2(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //             colors: [Colors.pinkAccent, Colors.orangeAccent],
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
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
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
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
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
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
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
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class trainingcalendar_page extends StatefulWidget {
  trainingcalendar_page({Key? key}) : super(key: key);

  @override
  _trainingcalendar_page createState() => _trainingcalendar_page();
}

class _trainingcalendar_page extends State<trainingcalendar_page> {
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/train/restful/?train_app_id=${Global.app_id}');
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

  // Future<void> getData() async {
  //   var url =
  //       (https://bc-official.com/api/app_nt/api/app/train/restful/?train_app_id=1);
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
        title: Center(child: Text('การฝึกอบรม')),
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
                colors: [ThemeBc.white, ThemeBc.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
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
    return Container(
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [ThemeBc.background, Colors.white],
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft)),
      height: 800,
      child: Container(
        //  color: ThemeBc.background,
        width: 1000,

        child: FutureBuilder<Map<String, dynamic>>(
          future: getDataSlide(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 330,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/trainingcalendardetail_page',
                                  arguments: {
                                    'trainName': snapshot.data!['data'][index]
                                        ['train_name'],
                                    'trainDetail': snapshot.data!['data'][index]
                                        ['train_detail'],

                                    'trainImages': snapshot.data!['data'][index]
                                                    ['train_images'][0]
                                                ['traini_path_name'] !=
                                            null
                                        ? Global.domainImage +
                                            snapshot.data!['data'][index]
                                                    ['train_images'][0]
                                                ['traini_path_name']
                                        : '${Global.networkImage}',
                                    //   'blog_images': snapshot.data!['data'][index]
                                    //               ['blog_images'] !=
                                    //           null
                                    //       ? Global.domainImage +
                                    //           snapshot.data!['data'][index]
                                    //                   ['blog_images'][0]
                                    //               ['blogi_path_name']
                                    //       : '${Global.networkImage}',
                                    //   'blog_name': snapshot.data!['data'][index]
                                    //       ['blog_name'],
                                    //   'blog_detail': snapshot.data!['data'][index]
                                    //       ['blog_detail']

                                    //   /*   'id': data[index].id,
                                    // 'detail': data[index].detail,
                                    // 'picture': data[index].picture,
                                    // 'view': data[index].view,*/
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 0),
                              child: Column(
                                children: [
                                  SizedBox(width: defaultMargin),
                                  Container(
                                    height: 300,
                                    width: 370,
                                    decoration: BoxDecoration(
                                        color: ThemeBc.grey,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0),
                                                ),
                                                child: Container(
                                                    height: 170,
                                                    child: Image.network(
                                                      snapshot.data!['data']
                                                                          [index]
                                                                      ['train_images'][0]
                                                                  [
                                                                  'traini_path_name'] !=
                                                              null
                                                          ? Global.domainImage +
                                                              snapshot.data!['data']
                                                                          [index]
                                                                      [
                                                                      'train_images'][0]
                                                                  [
                                                                  'traini_path_name']
                                                          : '${Global.networkImage}',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  boxShadow: [
                                                    // BoxShadow(
                                                    //     color: Colors.grey
                                                    //         .withOpacity(0.5),
                                                    //     offset: Offset(2, 2),
                                                    //     blurRadius: 7,
                                                    //     spreadRadius: 1.0),
                                                    // BoxShadow(
                                                    //     color: Colors.black
                                                    //         .withOpacity(0.5),
                                                    //     offset: Offset(2, 4),
                                                    //     blurRadius: 7.0,
                                                    //     spreadRadius: 1.0),
                                                  ]),
                                              height: 120,
                                              child: ListView(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${snapshot.data!['data'][index]['train_name']}',
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color:
                                                            ThemeBc.textblack,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'เนื้อหาอบรม : ${snapshot.data!['data'][index]['train_detail']}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,

                                                        // backgroundColor: Colors.black45,
                                                        color:
                                                            ThemeBc.textblack,
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
      ),
    );
  }
  // child: isLoading == true
  //     ? Center(
  //         child: CircularProgressIndicator(),
  //       )
  //     : ListView.separated(
  //         // scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return Center(
  //             child: Container(
  //               height: 500,
  //               child: ListView(
  //                 children: [
  //                   Card(
  //                     child: Row(
  //                       // mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             Navigator.pushNamed(context,
  //                                 '/trainingcalendardetail_page',
  //                                 arguments: {
  //                                   'trainName': data[index].trainName,
  //                                   'trainDetail':
  //                                       data[index].trainDetail,
  //                                   'trainImages': data[index]
  //                                               .trainImages !=
  //                                           null
  //                                       ? Global.domainImage +
  //                                           data[index]
  //                                               .trainImages[index]
  //                                               .trainiPathName
  //                                       : '${Global.networkImage}',
  //                                 });
  //                           },
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Row(
  //                               children: [
  //                                 Container(
  //                                   height: 200,
  //                                   child: Image.network(
  //                                     data[index].trainImages != null
  //                                         ? Global.domainImage +
  //                                             data[index]
  //                                                 .trainImages[index]
  //                                                 .trainiPathName
  //                                         : '${Global.networkImage}',
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Column(
  //                                     children: [
  //                                       Text(
  //                                         'การอบรม : ${data[index].trainName}',
  //                                         style:
  //                                             primaryTextStyle.copyWith(
  //                                                 fontSize: 15,
  //                                                 fontWeight: medium),
  //                                       ),
  //                                       Text(
  //                                         'วันที่จัดการอบรม : ${data[index].trainDetail}',
  //                                         style:
  //                                             primaryTextStyle.copyWith(
  //                                                 fontSize: 13,
  //                                                 fontWeight: medium),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //         separatorBuilder: (context, index) => Divider(),
  //         itemCount: data.length),

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

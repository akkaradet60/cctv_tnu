import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class travel_page extends StatefulWidget {
  travel_page({Key? key}) : super(key: key);

  @override
  _travel_page createState() => _travel_page();
}

class _travel_page extends State<travel_page> {
  bool isLoading = true;
  var hotlinee;

  @override
  void initState() {
    super.initState();
  }

  var travel;
  late Map<String, dynamic> imgSlide;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/travel/restful/?travel_app_id=1&travel_cat=1&travel_type=${travel['type_app_id']}');
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
  /* void _incrementCounter() {
    setState(() {
      _counter++;
      _product = _product + _product1;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    travel = ModalRoute.of(context)!.settings.arguments;
    Widget ss1(BuildContext context) {
      travel = ModalRoute.of(context)!.settings.arguments;
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          // decoration: BoxDecoration(
          //   color: secondaryTextColor,
          //   borderRadius: BorderRadius.circular(
          //     40,
          //   ),
          // ),
          height: 600,
          width: 500,

          child: FutureBuilder<Map<String, dynamic>>(
            future: getDataSlide(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!['data'].length,
                  itemBuilder: (context, index) {
                    print(snapshot.data!['data'][index]['travel_images'][0]
                        ['traveli_path_name']);

                    var datanill = snapshot.data!['data'];
                    print(snapshot.data!['data'].length);
                    var em_detaail;
                    if (datanill == 'ไม่พบข้อมูล') {
                      em_detaail = 'ไม่พบข้อมูล';
                      return Text('');
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 550,
                          width: 400,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/travelmap_page',
                                      arguments: {
                                        'travel_name': snapshot.data!['data']
                                            [index]['travel_name'],
                                        'travel_detail': snapshot.data!['data']
                                            [index]['travel_detail'],
                                        'travel_lat': snapshot.data!['data']
                                            [index]['travel_lat'],
                                        'travel_lng': snapshot.data!['data']
                                            [index]['travel_lng'],
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 500,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                child: Image.network(
                                                  snapshot.data!['data'][index][
                                                                  'travel_images'][0]
                                                              [
                                                              'traveli_path_name'] !=
                                                          null
                                                      ? Global.domainImage +
                                                          snapshot.data!['data']
                                                                      [index][
                                                                  'travel_images'][0]
                                                              [
                                                              'traveli_path_name']
                                                      : '${Global.networkImage}',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 60),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: ThemeBc.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(2, 2),
                                                            blurRadius: 7,
                                                            spreadRadius: 1.0),
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      // '${titles[_currentIndex]}',
                                                      'เที่ยว: ${snapshot.data!['data'][index]['travel_name']}',
                                                      style: TextStyle(
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color: ThemeBc.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 210),
                                                Container(
                                                  height: 170,
                                                  color: Colors.black54,
                                                  child: ListView(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text_pane(
                                                            text:
                                                                'ที่นี้คือ : ${snapshot.data!['data'][index]['travel_detail']}',
                                                            color:
                                                                ThemeBc.white,
                                                            fontSize: 15),
                                                      )
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
                            ],
                          ),
                        ),
                      );
                    }
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

    // Widget titleMenus() {
    //   return Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Container(
    //       height: 60,
    //       decoration: BoxDecoration(
    //           color: ThemeBc.background,
    //           borderRadius: BorderRadius.circular(
    //             30,
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.grey.withOpacity(0.5),
    //                 offset: Offset(2, 2),
    //                 blurRadius: 7,
    //                 spreadRadius: 1.0),
    //             BoxShadow(
    //                 color: Colors.black.withOpacity(0.5),
    //                 offset: Offset(2, 4),
    //                 blurRadius: 7.0,
    //                 spreadRadius: 1.0),
    //           ]),
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             Container(
    //               child: Text(
    //                 'แนะนำที่ท่องเที่ยวในมหาสารคาม',
    //                 style: TextStyle(
    //                   fontSize: 22.0,
    //                   fontWeight: FontWeight.bold,
    //                   // backgroundColor: Colors.black45,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // late List<String> titles = [
    //   ' 1 ',
    //   ' 2 ',
    //   ' 3 ',
    //   ' 4 ',
    //   ' 5',
    // ];
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Column(
            children: [
              Center(child: Text('${travel['type_name']}')),
            ],
          ),
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
                colors: [ThemeBc.white, ThemeBc.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  // titleMenus(),
                  // titleMenus(),

                  ss1(context),

                  //  sss2(context),
                ],
              ),
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

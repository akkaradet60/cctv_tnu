import 'package:cctv_tun/models/product/bestseller.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class products_page extends StatefulWidget {
  products_page({Key? key}) : super(key: key);

  @override
  _products_page createState() => _products_page();
}

class _products_page extends State<products_page> {
  bool isLoading = true;
  var hotlinee;
  var productt;
  var detail;

  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/otop/new-product/restful/?product_app_id=${Global.app_id}');
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
  //   var url = (Global.urlWeb +
  //       'api/app/otop/new-product/restful/?product_app_id=${Global.app_id}');
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   // print(json.decode(response.body));

  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final BestSeller paroduct =
  //         BestSeller.fromJson(json.decode(response.body));
  //     print(paroduct.data);
  //     setState(() {
  //       data = paroduct.data!;
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
        backgroundColor: ThemeBc.black,
        title: Text('สินค้า OTOP'),
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
      body: Column(
        children: [
          Container(
            color: ThemeBc.black,
            margin: EdgeInsets.only(top: 10, bottom: 0),
            width: 1000,
            height: 300,
            child: FutureBuilder<Map<String, dynamic>>(
              future: getDataSlide(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 190,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/productshop_page',
                                      arguments: {});
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 0),
                                  child: Column(
                                    children: [
                                      SizedBox(width: defaultMargin),
                                      Container(
                                        height: 200,
                                        width: 175,
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
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
                                                      height: 100,
                                                      child: Image.network(
                                                        snapshot.data!['data']
                                                                        [index]
                                                                    [
                                                                    'product_images'] !=
                                                                null
                                                            ? Global.domainImage +
                                                                snapshot.data!['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'product_images'][0]
                                                                    [
                                                                    'producti_path_name']
                                                            : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      )),
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  width: 170,
                                                  color: Colors.grey[200],
                                                  height: 70,
                                                  child: ListView(
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'ชื่อสินค้า : ${snapshot.data!['data'][index]['product_name']}',
                                                            style: primaryTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        medium),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 100,
                                                        child: ListView(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'เนื้อหา : ${snapshot.data!['data'][index]['product_detail']}',
                                                                style: primaryTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            medium),
                                                              ),
                                                            ),
                                                          ],
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
                      child:
                          Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           colors: [Colors.pinkAccent, Colors.orangeAccent],
      //           begin: Alignment.topRight,
      //           end: Alignment.bottomLeft)),
      //   child: isLoading == true
      //       ? Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : Container(
      //           height: 500,
      //           child: ListView(
      //             children: [
      //               Container(
      //                 width: 600,
      //                 height: 500,
      //                 child: ListView.separated(
      //                     scrollDirection: Axis.horizontal,
      //                     itemBuilder: (context, index) {
      //                       var app_image = data[index].productImage?[0] != null
      //                           ? data[index].productImage![0].productiPathName
      //                           : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

      //                       //  var   app_image = data[index].productImage![0].productiPathName ??
      //                       //         'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

      //                       return Center(
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             InkWell(
      //                               onTap: () {
      //                                 Navigator.pushNamed(
      //                                     context, '/productshop_page',
      //                                     arguments: {
      //                                       'productName':
      //                                           data[index].productName,
      //                                       'productPrice':
      //                                           data[index].productPrice,
      //                                       'productiPathName': data[index]
      //                                               .productImage?[0]
      //                                               .productiPathName ??
      //                                           'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
      //                                       'productiproductid': data[index]
      //                                           .productImage?[0]
      //                                           .productiProductId,

      //                                       /*   'id': data[index].id,
      //                                 'detail': data[index].detail,
      //                                 'picture': data[index].picture,
      //                                 'view': data[index].view,*/
      //                                     });
      //                               },
      //                               child: Container(
      //                                 margin:
      //                                     EdgeInsets.only(top: 20, bottom: 0),
      //                                 child: Row(
      //                                   children: [
      //                                     SizedBox(width: defaultMargin),
      //                                     Container(
      //                                       height: 400,
      //                                       width: 365,
      //                                       decoration: BoxDecoration(
      //                                           color: secondaryTextColor,
      //                                           borderRadius:
      //                                               BorderRadius.circular(
      //                                             24,
      //                                           ),
      //                                           boxShadow: [
      //                                             BoxShadow(
      //                                                 color: Colors.grey
      //                                                     .withOpacity(0.5),
      //                                                 offset: Offset(2, 2),
      //                                                 blurRadius: 7,
      //                                                 spreadRadius: 1.0),
      //                                             BoxShadow(
      //                                                 color: Colors.grey
      //                                                     .withOpacity(0.5),
      //                                                 offset: Offset(2, 4),
      //                                                 blurRadius: 7.0,
      //                                                 spreadRadius: 1.0),
      //                                           ]),
      //                                       child: Column(
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment.center,
      //                                         children: [
      //                                           Column(
      //                                             children: [
      //                                               Padding(
      //                                                 padding:
      //                                                     EdgeInsets.all(10.0),
      //                                                 child: Container(
      //                                                     child: Image.network(
      //                                                   app_image!,
      //                                                 )),
      //                                               ),
      //                                               SizedBox(height: 15),
      //                                               Container(
      //                                                 width: 340,
      //                                                 color: Colors.grey[200],
      //                                                 height: 100,
      //                                                 child: Column(
      //                                                   children: [
      //                                                     SizedBox(height: 15),
      //                                                     Container(
      //                                                       child: Text(
      //                                                         'ชื่อสินค้า:${data[index].productName} ',
      //                                                         style: primaryTextStyle
      //                                                             .copyWith(
      //                                                                 fontSize:
      //                                                                     18,
      //                                                                 fontWeight:
      //                                                                     medium),
      //                                                       ),
      //                                                     ),
      //                                                     SizedBox(height: 15),
      //                                                     Text(
      //                                                       'ราคาสินค้า : ${data[index].productPrice} บาท',
      //                                                       style: primaryTextStyle
      //                                                           .copyWith(
      //                                                               fontSize:
      //                                                                   20,
      //                                                               fontWeight:
      //                                                                   medium),
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               )
      //                                             ],
      //                                           )
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       );
      //                     },
      //                     separatorBuilder: (context, index) => Divider(),
      //                     itemCount: data.length),
      //               ),
      //             ],
      //           ),
      //         ),
      // ),
    );
  }
}

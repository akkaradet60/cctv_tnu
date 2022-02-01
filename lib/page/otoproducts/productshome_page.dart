import 'package:cctv_tun/models/product/bestseller.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class productshome_page extends StatefulWidget {
  productshome_page({Key? key}) : super(key: key);

  @override
  _productshome_page createState() => _productshome_page();
}

class _productshome_page extends State<productshome_page> {
  // List<Data> data = [];
  // bool isLoading = true;
  // Future<void> getData() async {
  //   var url =
  //       'https://www.bc-official.com/api/app_nt/api/app/otop/best-seller-product/restful/?product_app_id=${Global.app_id}';
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
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

  // Future<void> probests() async {
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

  // late Map< String,dynamic> profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: customBottomNav(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Center(child: Text('สินค้า OTOP')),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeBc.white,
                    borderRadius: BorderRadius.circular(
                      20,
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
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: ThemeBc.black,
                    size: 24.0,
                  ),
                  // Image.asset(
                  //   'assets/fi_home.png',
                  //   scale: 1,
                  // ),
                  tooltip: 'Show Snackbar',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/productstore_page'),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeBc.orange, ThemeBc.pinkAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [],
              ),
              //sso(context),
              propopular_page(context),
              probestseller_page(context),
              probestss(context),
            ],
          ),
        ));
  }

  // Widget sso(BuildContext context) {
  //   return Container(
  //     color: ThemeBc.background,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: secondaryTextColor,
  //             borderRadius: BorderRadius.circular(
  //               20,
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   offset: Offset(2, 2),
  //                   blurRadius: 7,
  //                   spreadRadius: 1.0),
  //               BoxShadow(
  //                   color: Colors.black.withOpacity(0.5),
  //                   offset: Offset(2, 4),
  //                   blurRadius: 7.0,
  //                   spreadRadius: 1.0),
  //             ]),
  //         child: SafeArea(
  //           child: Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //                 ),
  //                 TextField(
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(
  //                         20.0,
  //                       ),
  //                     ),
  //                     suffixIcon: IconButton(
  //                       icon: Icon(Icons.search),
  //                       onPressed: () =>
  //                           Navigator.pushNamed(context, '/productstore_page'),
  //                     ),
  //                     labelText: 'ค้นหา',
  //                     fillColor: Colors.white,
  //                     filled: true,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget probestss(BuildContext context) {
    bool isLoading = true;
    var hotlinee;
    var productt;
    var detail;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> probests() async {
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

    @override
    void initState() {
      super.initState();

      probests();
    }

    return Container(
      color: ThemeBc.background,
      width: 1000,
      height: 430,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'สินค้าขายดีอาทิตย์นี้',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 380,
            child: FutureBuilder<Map<String, dynamic>>(
              future: probests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 320,
                        height: 500,
                        child: Center(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/productshop_page',
                                      arguments: {
                                        'productName': snapshot.data!['data']
                                            [index]['product_name'],
                                        'productPrice': snapshot.data!['data']
                                            [index]['product_price'],
                                        'productiPathName': snapshot
                                                                .data!['data']
                                                            [index]
                                                        ['product_images'][0]
                                                    ['producti_path_name'] !=
                                                null
                                            ? Global.domainImage +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                      });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Container(
                                        height: 350,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 2),
                                              //     blurRadius: 7,
                                              //     spreadRadius: 1.0),
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 4),
                                              //     blurRadius: 7.0,
                                              //     spreadRadius: 1.0),
                                            ]),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                          boxShadow: [
                                                            //     spreadRadius: 1.0),
                                                          ]),
                                                      height: 230,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0)),
                                                        child: Image.network(
                                                          snapshot.data!['data']
                                                                              [index]
                                                                          ['product_images'][0]
                                                                      [
                                                                      'producti_path_name'] !=
                                                                  null
                                                              ? Global.domainImage +
                                                                  snapshot.data!['data']
                                                                              [index]
                                                                          [
                                                                          'product_images'][0]
                                                                      [
                                                                      'producti_path_name']
                                                              : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                      boxShadow: [
                                                        //     spreadRadius: 1.0),
                                                      ]),
                                                  width: 280,
                                                  height: 80,
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
                                                        height: 60,
                                                        child: ListView(
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Text(
                                                                  'ราคา : ${snapshot.data!['data'][index]['product_price']}',
                                                                  style: primaryTextStyle.copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          medium),
                                                                ),
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
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget probestseller_page(BuildContext context) {
    bool isLoading = true;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> probests() async {
      var url = (Global.urlWeb +
          'api/app/otop/best-seller-product/restful/?product_app_id=${Global.app_id}');
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
    void initState() {
      super.initState();

      probests();
    }

    return Container(
      color: ThemeBc.background,
      width: 1000,
      height: 430,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ยอดนิยมประจำสัมปดาห์',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 380,
            child: FutureBuilder<Map<String, dynamic>>(
              future: probests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 320,
                        height: 500,
                        child: Center(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/productshop_page',
                                      arguments: {
                                        'productName': snapshot.data!['data']
                                            [index]['product_name'],
                                        'productPrice': snapshot.data!['data']
                                            [index]['product_price'],
                                        'productiPathName': snapshot
                                                                .data!['data']
                                                            [index]
                                                        ['product_images'][0]
                                                    ['producti_path_name'] !=
                                                null
                                            ? Global.domainImage +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                      });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Container(
                                        height: 350,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 2),
                                              //     blurRadius: 7,
                                              //     spreadRadius: 1.0),
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 4),
                                              //     blurRadius: 7.0,
                                              //     spreadRadius: 1.0),
                                            ]),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                          boxShadow: [
                                                            //     spreadRadius: 1.0),
                                                          ]),
                                                      height: 230,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0)),
                                                        child: Image.network(
                                                          snapshot.data!['data']
                                                                              [index]
                                                                          ['product_images'][0]
                                                                      [
                                                                      'producti_path_name'] !=
                                                                  null
                                                              ? Global.domainImage +
                                                                  snapshot.data!['data']
                                                                              [index]
                                                                          [
                                                                          'product_images'][0]
                                                                      [
                                                                      'producti_path_name']
                                                              : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                      boxShadow: [
                                                        //     spreadRadius: 1.0),
                                                      ]),
                                                  width: 280,
                                                  height: 80,
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
                                                        height: 60,
                                                        child: ListView(
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Text(
                                                                  'ราคา : ${snapshot.data!['data'][index]['product_price']}',
                                                                  style: primaryTextStyle.copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          medium),
                                                                ),
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
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget propopular_page(BuildContext context) {
    bool isLoading = true;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> probests() async {
      var url = (Global.urlWeb +
          '/api/app/otop/popular-product/restful/?product_app_id=${Global.app_id}');
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
    void initState() {
      super.initState();

      probests();
    }

    return Container(
      width: 1000,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ใหม่ล่าสุด',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 200,
            child: FutureBuilder<Map<String, dynamic>>(
              future: probests(),
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
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/productshop_page',
                                      arguments: {
                                        'productName': snapshot.data!['data']
                                            [index]['product_name'],
                                        'productPrice': snapshot.data!['data']
                                            [index]['product_price'],
                                        'productiPathName': snapshot
                                                                .data!['data']
                                                            [index]
                                                        ['product_images'][0]
                                                    ['producti_path_name'] !=
                                                null
                                            ? Global.domainImage +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                        // data[index]
                                        //     .productImage![0]
                                        //     .productiProductId,
                                      });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Container(
                                        height: 190,
                                        width: 175,
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 2),
                                              //     blurRadius: 7,
                                              //     spreadRadius: 1.0),
                                              // BoxShadow(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.5),
                                              //     offset: Offset(2, 4),
                                              //     blurRadius: 7.0,
                                              //     spreadRadius: 1.0),
                                            ]),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Container(
                                                      height: 110,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0)),
                                                        child: Image.network(
                                                          snapshot.data!['data']
                                                                              [index]
                                                                          ['product_images'][0]
                                                                      [
                                                                      'producti_path_name'] !=
                                                                  null
                                                              ? Global.domainImage +
                                                                  snapshot.data!['data']
                                                                              [index]
                                                                          [
                                                                          'product_images'][0]
                                                                      [
                                                                      'producti_path_name']
                                                              : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(height: 0),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                      boxShadow: [
                                                        // BoxShadow(
                                                        //     color: Colors.grey
                                                        //         .withOpacity(0.5),
                                                        //     offset: Offset(2, 2),
                                                        //     blurRadius: 7,
                                                        //     spreadRadius: 1.0),
                                                        // BoxShadow(
                                                        //     color: Colors.grey
                                                        //         .withOpacity(0.5),
                                                        //     offset: Offset(2, 4),
                                                        //     blurRadius: 7.0,
                                                        //     spreadRadius: 1.0),
                                                      ]),
                                                  width: 170,
                                                  // color: Colors.grey[200],
                                                  height: 60,
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
                                                        height: 60,
                                                        child: ListView(
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Text(
                                                                  'ราคา : ${snapshot.data!['data'][index]['product_price']}',
                                                                  style: primaryTextStyle.copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          medium),
                                                                ),
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
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
  // Widget customBottomNav() {
  //   return Container(
  //     height: 60,
  //     child: BottomAppBar(
  //         shape: CircularNotchedRectangle(),
  //         notchMargin: 5,
  //         color: Colors.pink,
  //         clipBehavior: Clip.antiAlias,
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 SizedBox(
  //                   width: 20,
  //                 ),
  //                 IconButton(
  //                   icon: Image.asset(
  //                     'assets/fi_home.png',
  //                     scale: 1,
  //                   ),
  //                   tooltip: 'Show Snackbar',
  //                   onPressed: () => Navigator.pushNamed(
  //                       context, '/productshome_page'), //productshome_page
  //                 ),
  //                 SizedBox(
  //                   width: 260,
  //                 ),
  //                 IconButton(
  //                   icon: Image.asset(
  //                     'assets/10.png',
  //                     scale: 1,
  //                     color: Colors.red[900],
  //                   ),
  //                   tooltip: 'Show Snackbar',
  //                   onPressed: () =>
  //                       Navigator.pushNamed(context, '/otopproductslike'),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         )),
  //   );
  // }
}

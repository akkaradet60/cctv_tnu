import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class productshome_page extends StatefulWidget {
  productshome_page({Key? key}) : super(key: key);

  @override
  _productshome_page createState() => _productshome_page();
}

class _productshome_page extends State<productshome_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: customBottomNav(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.app_white_color, //change your color here
          ),
          foregroundColor: ThemeBc.app_white_color,
          backgroundColor: ThemeBc.app_theme_color,
          title: Column(
            children: [
              Center(
                  child: LocaleText(
                'สินค้าโอทอป',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.app_textwhite_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeBc.app_white_color,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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
                      Navigator.pushNamed(context, '/productsearchome'),
                ),
              ),
            ),
          ],
        ), //ThemeBc.green05
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ThemeBc.app_linear_on,
              ThemeBc.app_linear_lower,
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
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
              SizedBox(height: 12),
              propopular_page(context),
              probestseller_page(context),
              probestss(context),
            ],
          ),
        ));
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'สินค้าขายดีอาทิตย์นี้',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.app_textwhite_color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
                  if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeBc.app_linear_on,
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
                                  color: ThemeBc.app_textwhite_color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
                                        'product_detail': snapshot.data!['data']
                                            [index]['product_detail'],
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
                                            ? Global.domainImagenew +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : '${Global.domainImagenew}',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Container(
                                            height: 350,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: secondaryTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      spreadRadius: 1.0),
                                                  // BoxShadow(
                                                  //     color: Colors.grey
                                                  //         .withOpacity(0.5),
                                                  //     offset: Offset(2, 4),
                                                  //     blurRadius: 7.0,
                                                  //     spreadRadius: 1.0),
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Container(
                                                      height: 230,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        child: Image.network(
                                                          Global.domainImagenew +
                                                                      snapshot.data!['data'][index]['product_images']
                                                                              [0]
                                                                          [
                                                                          'producti_path_name'] !=
                                                                  null
                                                              ? Global.domainImagenew +
                                                                  snapshot.data!['data']
                                                                              [index]
                                                                          [
                                                                          'product_images'][0]
                                                                      [
                                                                      'producti_path_name']
                                                              : '${Global.networkImage}',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 30,
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: [
                                                            Text(
                                                              '${snapshot.data!['data'][index]['product_name']}',
                                                              style: GoogleFonts
                                                                  .sarabun(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: ThemeBc
                                                                      .app_textblack_color,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '${snapshot.data!['data'][index]['product_price']} บาท',
                                                        style:
                                                            GoogleFonts.sarabun(
                                                          textStyle: TextStyle(
                                                            color: ThemeBc
                                                                .app_textblack_color,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
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

                return Center(
                    child: SpinKitThreeInOut(
                  color: ThemeBc.app_linear_on,
                ));
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'ยอดนิยมประจำสัมปดาห์',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.app_textwhite_color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
                  if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeBc.app_linear_on,
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
                                  color: ThemeBc.app_textwhite_color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
                                        'product_detail': snapshot.data!['data']
                                            [index]['product_detail'],
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
                                            ? Global.domainImagenew +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : '${Global.domainImagenew}',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Container(
                                            height: 350,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: secondaryTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      spreadRadius: 1.0),
                                                  // BoxShadow(
                                                  //     color: Colors.grey
                                                  //         .withOpacity(0.5),
                                                  //     offset: Offset(2, 4),
                                                  //     blurRadius: 7.0,
                                                  //     spreadRadius: 1.0),
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Container(
                                                      height: 230,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        child: Image.network(
                                                          Global.domainImagenew +
                                                                      snapshot.data!['data'][index]['product_images']
                                                                              [0]
                                                                          [
                                                                          'producti_path_name'] !=
                                                                  null
                                                              ? Global.domainImagenew +
                                                                  snapshot.data!['data']
                                                                              [index]
                                                                          [
                                                                          'product_images'][0]
                                                                      [
                                                                      'producti_path_name']
                                                              : '${Global.networkImage}',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 30,
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: [
                                                            Text(
                                                              '${snapshot.data!['data'][index]['product_name']}',
                                                              style: GoogleFonts
                                                                  .sarabun(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: ThemeBc
                                                                      .app_textblack_color,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '${snapshot.data!['data'][index]['product_price']} บาท',
                                                        style:
                                                            GoogleFonts.sarabun(
                                                          textStyle: TextStyle(
                                                            color: ThemeBc
                                                                .app_textblack_color,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
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

                return Center(
                    child: SpinKitThreeInOut(
                  color: ThemeBc.app_linear_on,
                ));
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'ใหม่ล่าสุด',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.app_textwhite_color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 220,
            child: FutureBuilder<Map<String, dynamic>>(
              future: probests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeBc.app_linear_on,
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
                                  color: ThemeBc.app_textwhite_color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
                                        'product_detail': snapshot.data!['data']
                                            [index]['product_detail'],
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
                                            ? Global.domainImagenew +
                                                snapshot.data!['data'][index]
                                                        ['product_images'][0]
                                                    ['producti_path_name']
                                            : '${Global.networkImage}',
                                        'productiproductid':
                                            snapshot.data!['data'][index]
                                                    ['product_images'][0]
                                                ['producti_product_id'],
                                        // data[index]
                                        //     .productImage![0]
                                        //     .productiProductId,
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Container(
                                          height: 190,
                                          width: 175,
                                          decoration: BoxDecoration(
                                              color: secondaryTextColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 7,
                                                    spreadRadius: 1.0),
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
                                                    padding: EdgeInsets.all(0),
                                                    child: Container(
                                                        height: 110,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          child: Image.network(
                                                            snapshot.data!['data'][index]
                                                                            [
                                                                            'product_images'][0]
                                                                        [
                                                                        'producti_path_name'] !=
                                                                    null
                                                                ? Global.domainImagenew +
                                                                    snapshot.data!['data']
                                                                            [
                                                                            index]['product_images'][0]
                                                                        [
                                                                        'producti_path_name']
                                                                : '${Global.networkImage}',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(height: 0),
                                                  Container(
                                                    height: 70,
                                                    child: ListView(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 170,
                                                                height: 30,
                                                                child: ListView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            '${snapshot.data!['data'][index]['product_name']}',
                                                                            style:
                                                                                GoogleFonts.sarabun(
                                                                              textStyle: TextStyle(
                                                                                color: ThemeBc.app_textblack_color,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                '${snapshot.data!['data'][index]['product_price']} บาท',
                                                                style:
                                                                    GoogleFonts
                                                                        .sarabun(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: ThemeBc
                                                                        .app_textblack_color,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        10,
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
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {}

                return Center(
                    child: SpinKitThreeInOut(
                  color: ThemeBc.app_linear_on,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
          title: Column(
            children: [
              Center(child: LocaleText('สินค้าโอทอป')),
            ],
          ),
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
                      Navigator.pushNamed(context, '/productsearchome'),
                ),
              ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'สินค้าขายดีอาทิตย์นี้',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: ThemeBc.textblack,
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
                                                20,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
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
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
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
                                                                  Radius
                                                                      .circular(
                                                                          20.0)),
                                                          child: Image.network(
                                                            Global.domainImagenew +
                                                                        snapshot.data!['data'][index]['product_images'][0]
                                                                            [
                                                                            'producti_path_name'] !=
                                                                    null
                                                                ? Global.domainImagenew +
                                                                    snapshot.data!['data'][index]
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
                                                  SizedBox(height: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          20,
                                                        ),
                                                        boxShadow: [
                                                          //     spreadRadius: 1.0),
                                                        ]),
                                                    width: 280,
                                                    height: 80,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 40,
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      LocaleText(
                                                                        'ชื่อสินค้า',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ' : ${snapshot.data!['data'][index]['product_name']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 170,
                                                          height: 40,
                                                          child: Column(
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      LocaleText(
                                                                        'ราคา',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ' : ${snapshot.data!['data'][index]['product_price']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'ยอดนิยมประจำสัมปดาห์',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.black45,
                  color: ThemeBc.textblack),
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
                                                20,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
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
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
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
                                                                  Radius
                                                                      .circular(
                                                                          20.0)),
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
                                                  SizedBox(height: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          20,
                                                        ),
                                                        boxShadow: [
                                                          //     spreadRadius: 1.0),
                                                        ]),
                                                    width: 280,
                                                    height: 80,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 40,
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      LocaleText(
                                                                        'ชื่อสินค้า',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ' : ${snapshot.data!['data'][index]['product_name']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 170,
                                                          height: 40,
                                                          child: Column(
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      LocaleText(
                                                                        'ราคา',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ' : ${snapshot.data!['data'][index]['product_price']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocaleText(
              'ใหม่ล่าสุด',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: ThemeBc.textblack,
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
                                                20,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
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
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Container(
                                                        height: 110,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20.0)),
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
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    20,
                                                                  ),
                                                                  boxShadow: []),
                                                          width: 190,
                                                          // color: Colors.grey[200],
                                                          height: 70,
                                                          child: Column(
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
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            LocaleText(
                                                                              'ชื่อสินค้า',
                                                                              style: TextStyle(
                                                                                fontSize: 10.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                // backgroundColor: Colors.black45,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              ' : ${snapshot.data!['data'][index]['product_name']}',
                                                                              style: TextStyle(
                                                                                fontSize: 10.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                // backgroundColor: Colors.black45,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 170,
                                                                height: 30,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        LocaleText(
                                                                          'ราคา',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            // backgroundColor: Colors.black45,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' : ${snapshot.data!['data'][index]['product_price']}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            // backgroundColor: Colors.black45,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
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

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

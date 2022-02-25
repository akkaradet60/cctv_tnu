import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var productt;

class productstorehome extends StatefulWidget {
  productstorehome({Key? key}) : super(key: key);

  @override
  _productshop_page createState() => _productshop_page();
}

class _productshop_page extends State<productstorehome> {
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  // Future<Map<String, dynamic>> getDataSlide() async {
  //   var url =
  //       ('https://www.bc-official.com/api/app_nt/api/app/otop/search-otop/restful/?otop_app_id=1');
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Authorization':
  //         'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
  //   });

  //   if (response.statusCode == 200) {
  //     imgSlide = json.decode(response.body);

  //     // print(imgSlide['data'].length);
  //     return imgSlide;
  //   } else {
  //     throw Exception('$response.statusCode');
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productt = ModalRoute.of(context)!.settings.arguments;
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
              Center(child: LocaleText('ร้านค้า')),
            ],
          ),
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ThemeBc.background, ThemeBc.background],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: secondaryTextColor,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        productt['otop_image'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Container(
                          height: 1000,
                          width: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                      color: ThemeBc.background,
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            offset: Offset(2, 4),
                                            blurRadius: 7.0,
                                            spreadRadius: 1.0),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.article,
                                              size: 40,
                                              color: ThemeBc.white,
                                            ),
                                            SizedBox(width: 10),
                                            LocaleText(
                                              'ชื่อร้านค้า',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                            Text(
                                              ' : ${productt['otop_name']}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 18),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(2, 4),
                                                    blurRadius: 7.0,
                                                    spreadRadius: 1.0),
                                              ]),
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 350,
                                                height: 150,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: ListView(
                                                    children: [
                                                      LocaleText(
                                                        'รายละเอียดร้านค้า',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${productt['otop_dateil']}',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${productt['otop_id']}',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ), //product_detail
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: ThemeBc.black,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text_pane(
                                              text: 'สินค้าของร้านค้า',
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
                              ),
                              probestseller_page(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget probestseller_page(BuildContext context) {
    productt = ModalRoute.of(context)!.settings.arguments;
    bool isLoading = true;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> probests() async {
      var url =
          ('https://www.bc-official.com/api/app_nt/api/app/otop/product/restful/?product_otop_id=${productt['otop_id']}&product_app_id=1');
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
      });
      var feedback = jsonDecode(response.body);
      if (response.statusCode == 200) {
        imgSlide = json.decode(response.body);

        print(imgSlide);
        // print(imgSlide['data'].length);
        return imgSlide;
      } else {
        throw Exception('$response.statusCode');
      }
      if (feedback['data'] == "ไม่พบข้อม") {}
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
          SizedBox(height: 5),
          Container(
            height: 400,
            child: FutureBuilder<Map<String, dynamic>>(
              future: probests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    // scrollDirection: Axis.horizontal,
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
}
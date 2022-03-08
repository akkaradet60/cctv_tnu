import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class travelhome_page extends StatefulWidget {
  travelhome_page({Key? key}) : super(key: key);

  @override
  _productshome_page createState() => _productshome_page();
}

class _productshome_page extends State<travelhome_page> {
  late Map<String, dynamic> imgSlide;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url =
        ('http://113.53.239.193/tedsaban/api/app/travel/type/restful/?type_app_id=${Global.app_id}');
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
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            color: ThemeBc.white,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeBc.green05,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 7,
                        spreadRadius: 1.0),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.festival,
                        size: 30,
                        color: ThemeBc.white,
                      ),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        Navigator.pushNamed(context, '/travelhome_page');
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.room,
                      size: 30,
                      color: ThemeBc.white,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.pushNamed(context, '/travelmapS_page');
                    },
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.kitesurfing,
                  //     size: 30,
                  //     color: ThemeBc.white,
                  //   ),
                  //   tooltip: 'Show Snackbar',
                  //   onPressed: () {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('กำลังพัฒนา')));
                  //   },
                  // ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.landscape,
                  //     size: 30,
                  //     color: ThemeBc.white,
                  //   ),
                  //   tooltip: 'Show Snackbar',
                  //   onPressed: () {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('กำลังพัฒนา')));
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
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
                'ท่องเที่ยว',
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
              onPressed: () {},
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
              ss1(context),
            ],
          ),
        ));
  }

  Widget ss1(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: ThemeBc.white,
            margin: EdgeInsets.only(top: 10, bottom: 0),
            width: 500,
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
                  return ListView.builder(
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/travel_page',
                                  arguments: {
                                    'type_app_id': snapshot.data!['data'][index]
                                        ['type_app_id'],
                                    'type_id': snapshot.data!['data'][index]
                                        ['type_id'],
                                    'type_name': snapshot.data!['data'][index]
                                        ['type_name'],
                                  }); //type_id
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            child: Image.network(
                                              snapshot.data!['data'][index]
                                                          ['type_image'] !=
                                                      null
                                                  ? Global.domainImagenew +
                                                      snapshot.data!['data']
                                                          [index]['type_image']
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
                                                  color: ThemeBc.green05,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5,
                                                  ),
                                                  boxShadow: []),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // '${titles[_currentIndex]}',
                                                  '${snapshot.data!['data'][index]['type_name']}',
                                                  style: GoogleFonts.sarabun(
                                                    textStyle: TextStyle(
                                                      color: ThemeBc.textwhite,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 40),
                                            Container(
                                              height: 140,
                                              color: Colors.black54,
                                              child: ListView(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text_pane(
                                                        text:
                                                            '  ${snapshot.data!['data'][index]['type_detail']}',
                                                        color: ThemeBc.white,
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
        ),
      ],
    );
  }
}

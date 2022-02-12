// import 'package:flutter/cupertino.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/widgets/text_FormBuilderField.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:cctv_tun/widgets/custom_button.dart';
import 'package:cctv_tun/widgets/warn_compose_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
// import 'package:smartcity_nt_mobile/global.dart';
// import 'package:smartcity_nt_mobile/redux/app_reducer.dart';
// import 'package:smartcity_nt_mobile/style/global.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

//pic

import 'package:image_picker/image_picker.dart';

// import 'package:google_place/google_place.dart';
class warn_page extends StatefulWidget {
  @override
  _warn_page createState() => _warn_page();
}

double long = 0;
double lat = 0;
LatLng point = LatLng(long, lat);
var location = [];

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

late Position userLocation;
Future<Position> _getLocation() async {
  try {
    userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  } catch (e) {
    userLocation != null;
  }
  return userLocation;
}

List<Marker> markers = [];
List<LatLng> polylineCoordinates = [];

class _warn_page extends State<warn_page> with SingleTickerProviderStateMixin {
  late Map<String, dynamic> imgSlide;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/emergency/restful/?em_user_id=${Global.user_id}&em_app_id=${Global.app_id}&em_category=1');
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

  final tabList = ['แจ้งเหตุฉุกเฉิน', 'เหตุฉุกเฉินของท่าน'];
  var em_location = 'ยังไม่ได้เลือก';
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
    _getStateList();
    // findLatLng();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<void> addEmergecy(Map formValues) async {
    int index = 0;
    late String position = 'ยังไม่ได้เลือก';
    try {
      if (formValues['em_detail'] != null &&
          formValues['em_phone'] != null &&
          formValues['em_owner'] != null &&
          formValues['em_type'] != null) {
        var url = Uri.parse(Global.urlWeb + 'api/app/emergency/restful/');
        var request = http.MultipartRequest('POST', url)
          ..fields['em_app_id'] = Global.app_id
          ..fields['em_user_id'] = Global.user_id
          ..fields['em_detail'] = formValues['em_detail']
          ..fields['em_phone'] = formValues['em_phone']
          ..fields['em_owner'] = formValues['em_owner']
          ..fields['em_lat'] = '1'
          ..fields['em_lng'] = '1'
          ..fields['em_location'] = em_location
          ..fields['em_category'] = '1'
          ..fields['em_type'] = formValues['em_type'];

        Map<String, String> headers = {
          "Accept": "application/json",
          "Content-type": "multipart/form-data",
          "Authorization":
              'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
        };

        for (XFile item in formValues['emi_path_name'] ?? []) {
          request.files.add(
              await http.MultipartFile.fromPath('emi_path_name[]', item.path));
          index++;
        }

        request.headers.addAll(headers);
        var res = await request.send();
        http.Response response = await http.Response.fromStream(res);

        var feedback = jsonDecode(response.body);
        print(feedback);
        if (feedback['data'] == "สำเร็จ") {
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title: '${feedback['data']}',
                title2: '',
              );
            },
          );
          // alertSuccess(context, '${feedback['data']}');
        } else {
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title: 'ใส่ข้อมูลให้ครบถ้วน',
                title2: '',
              );
            },
          );
        }
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return warn_api(
              title: 'ใส่ข้อมูลให้ครบถ้วน',
              title2: '',
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  List statesList = [
    {
      "emt_id": "0",
      "emt_category": "0",
      "emt_name": "ไม่พบข้อมูล",
    },
  ];
  String? _myState;

  Future<void> _getStateList() async {
    String stateInfoUrl = Global.urlWeb +
        'api/app/emergency/type/restful/?emt_app_id=${Global.app_id}&emt_category=1';

    await http.get(Uri.parse(stateInfoUrl),
        headers: {'Authorization': 'Bearer ${Global.token}'}).then((response) {
      var data = json.decode(response.body);

      //print(data['data']);
      if (data['data'] != "ไม่พบข้อมูล") {
        setState(() {
          statesList = data['data'];
        });
      }
    });
  }
//pic

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    // print(em_location);

    Widget emergecyPage1() {
      return StoreConnector<AppState, Map<String, dynamic>>(
          distinct: true,
          converter: (store) => store.state.profileState.profile,
          builder: (context, profile) {
            var user_phone = profile['user_phone'] ?? '';
            var user_firstname = profile['user_firstname'] != null
                ? '${profile['user_firstname']} ${profile['user_lastname']}'
                : '';

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text('เลือกประเภทการแจ้งเหตุ',
                    //     style: TextStyle(fontSize: 15)),
                    // const Divider(),
                    // const SizedBox(height: 40),
                    FormBuilder(
                      key: _fbKey,
                      initialValue: {
                        'em_type': _myState,

                        // '2': '-',
                        'em_phone': user_phone,
                        'em_detail': '',
                        // '5': '',
                        //  'em_location': '$em_location',
                        // 'em_lat': '',
                        // 'em_lng': '',
                        // 'em_app_id': '1',
                        'em_owner': '${user_firstname}'
                      },
                      autovalidateMode: AutovalidateMode
                          .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 18),
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryTextColor,
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: FormBuilderDropdown(
                                  name: 'em_type',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        20.0,
                                      ),
                                    ),
                                    suffixIcon: Icon(Icons.email),
                                    labelText: 'เลือกประเภทการแจ้งเหตุ',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  allowClear: true,
                                  hint: Text('เลือกประเภทการแจ้งเหตุ'),
                                  onChanged: (value) => setState(
                                      () => _myState = value as String?),
                                  items: statesList.map((item) {
                                    return new DropdownMenuItem(
                                      // value: '1', child: Text('ผู้ป่วยฉุกเฉิน')
                                      child: new Text(item['emt_name']),
                                      value: item['emt_id'].toString(),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          FormBuilderFieldText(
                              name: 'em_owner',
                              labelText: 'ชื่อผู้แจ้ง',
                              icon: Icons.email,
                              initialValue: ''),
                          SizedBox(height: 18),
                          FormBuilderFieldText(
                              name: 'em_phone',
                              labelText: 'เบอร์โทรศัพท์',
                              icon: Icons.safety_divider,
                              initialValue: ''),
                          SizedBox(height: 18),
                          FormBuilderFieldText(
                              name: 'em_detail',
                              labelText: 'รายละเอียดเหตุการณ์',
                              icon: Icons.mail,
                              initialValue: ''),
                          SizedBox(height: 18),
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryTextColor,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(2, 2),
                                      blurRadius: 7,
                                      spreadRadius: 1.0),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FormBuilderImagePicker(
                                name: 'emi_path_name',
                                displayCustomType: (obj) =>
                                    obj is ApiImage ? obj.imageUrl : obj,
                                iconColor: Colors.black,
                                decoration: InputDecoration(
                                  suffixIconColor: ThemeBc.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                  ),
                                  labelText: 'ภาพ',
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                maxImages: 5,
                                onSaved: (val) {
                                  print(val);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          FutureBuilder(
                              future: _getLocation(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    height: 320,
                                    child: ListView(
                                      children: [
                                        Container(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: secondaryTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      spreadRadius: 1.0),
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      offset: Offset(2, 4),
                                                      blurRadius: 7.0,
                                                      spreadRadius: 1.0),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 300,
                                                child: Column(
                                                  children: [
                                                    Flexible(
                                                        child: FlutterMap(
                                                      options: MapOptions(
                                                          onTap: (tapPosition,
                                                              p) async {
                                                            setState(() {
                                                              point = p;
                                                            });
                                                          },
                                                          center: LatLng(
                                                              userLocation
                                                                  .latitude,
                                                              userLocation
                                                                  .longitude),
                                                          zoom: 16),
                                                      layers: [
                                                        TileLayerOptions(
                                                          urlTemplate:
                                                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                          subdomains: [
                                                            'a',
                                                            'b',
                                                            'c'
                                                          ],
                                                          attributionBuilder:
                                                              (_) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ThemeBc
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        20,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "เทศบาลมหาสารคาม",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              ThemeBc.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        MarkerLayerOptions(
                                                            markers: [
                                                              Marker(
                                                                width: 80.0,
                                                                height: 80.0,
                                                                point: point,
                                                                builder: (ctx) =>
                                                                    Container(
                                                                  child: Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              Marker(
                                                                point: LatLng(
                                                                    userLocation
                                                                        .latitude,
                                                                    userLocation
                                                                        .longitude),
                                                                builder: (ctx) =>
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .my_location),
                                                                  tooltip:
                                                                      'Show Snackbar',
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              Column(
                                                                            children: [
                                                                              Text('ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} '),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            ]),
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  // Text('${userLocation.latitude} ${userLocation.longitude}');
                                } else {
                                  return Center(
                                    child: Column(
                                      children: <Widget>[
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              }),
                          SizedBox(height: 10),
                          Container(
                              width: 400,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: secondaryTextColor,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'ตำแหน่ง ! \nตำแหน่งที่คุณเลือก : $point',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        // backgroundColor: Colors.black45,
                                        color: ThemeBc.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 18),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 0, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  title: 'แจ้งเหตุฉุกเฉิน',
                                  onPressed: () {
                                    if (_fbKey.currentState!
                                        .saveAndValidate()) {
                                      print(_fbKey.currentState!.value);
                                      addEmergecy(_fbKey.currentState!.value);
                                    }
                                  },
                                  colorButton: ThemeBc.background,
                                  textStyle: secondaryTextStyle.copyWith(
                                      fontWeight: medium, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    Widget emergecyPage2() {
      return Container(
        child: Container(
          width: 1000,
          height: 1000,
          child: FutureBuilder<Map<String, dynamic>>(
            future: getDataSlide(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, index) {
                      var datanill = snapshot.data!['data'];
                      print(snapshot.data!['data'].length);
                      var em_detaail;
                      if (datanill == 'ไม่พบข้อมูล') {
                        em_detaail = 'ไม่พบข้อมูล';
                        return Text('');
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              W_C_Detali(
                                name:
                                    '${snapshot.data!['data'][index]['em_detail']}',
                                onPressed: () => Navigator.pushNamed(
                                    context, '/composedetail_page',
                                    arguments: {
                                      'em_owner': snapshot.data!['data'][index]
                                          ['em_owner'],
                                      'em_detail': snapshot.data!['data'][index]
                                          ['em_detail'],
                                      'em_images': snapshot.data!['data'][index]
                                                  ['em_images'] !=
                                              null
                                          ? Global.domainImage +
                                              snapshot.data!['data'][index]
                                                      ['em_images'][0]
                                                  ['emi_path_name']
                                          : '${Global.networkImage}',
                                      'em_phone': snapshot.data!['data'][index]
                                          ['em_phone'],
                                      'em_lat': snapshot.data!['data'][index]
                                          ['em_lat'],
                                      'em_lng': snapshot.data!['data'][index]
                                          ['em_lng'],
                                      'em_location': snapshot.data!['data']
                                          [index]['em_location'],
                                      'em_type': snapshot.data!['data'][index]
                                          ['em_type'],
                                    }),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
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

    return Scaffold(
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: const LocaleText('แจ้งเหตุฉุกเฉิน',
            style: TextStyle(color: ThemeBc.white)),
        centerTitle: true,
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
        bottom: TabBar(
          controller: _tabController,
          // indicator: PointTabIndicator(
          //   position: PointTabIndicatorPosition.bottom,
          //   color: white,
          //   insets: EdgeInsets.only(bottom: 6),
          // ),
          tabs: tabList.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: TabBarView(
          controller: _tabController,
          children: tabList.map((item) {
            if (item == 'แจ้งเหตุฉุกเฉิน') {
              return emergecyPage1();
            } else {
              return emergecyPage2();
            }
            // print(item);
            // return Center(child: Text(item));
          }).toList(),
        ),
      ),
    );
  }
}

// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:cctv_tun/page/profile/app_reducer.dart';
// import 'package:cctv_tun/page/profile/profile_action.dart';
// import 'dart:io';
// import 'package:cctv_tun/widgets/custom_button.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';

// import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:latlong2/latlong.dart';
// import 'dart:convert';

// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class warn_page extends StatefulWidget {
//   warn_page({Key? key}) : super(key: key);

//   @override
//   _warn1State createState() => _warn1State();
// }

// class ApiImage {
//   final String imageUrl;
//   final String id;
//   ApiImage({
//     required this.imageUrl,
//     required this.id,
//   });
// }

// class _warn1State extends State<warn_page> with SingleTickerProviderStateMixin {
//   Future<Position> _getLocation() async {
//     try {
//       userLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//     } catch (e) {
//       userLocation != null;
//     }
//     return userLocation;
//   }

//   var hotlinee;

//   late Position userLocation;
//   final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
//   final tabList = [
//     'แจ้งเหตุฉุกเฉิน',
//     'เหตุฉุกเฉินของท่าน',
//   ];

//   late TabController _tabController;

//   double? lat, lng;

//   @override
//   void initState() {
//     _tabController = TabController(vsync: this, length: tabList.length);
//     super.initState();
//   }

//   var selectedImage;
//   var resJson = '1';
//   var profilee;
//   var newProfile;
//   Future<void> getProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     newProfile = json.decode(prefs.getString('profile').toString());
//     //call redux action
//     final store = StoreProvider.of<AppState>(context);
//     store.dispatch(updateProfileAction(newProfile));
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     await prefs.remove('profile');
//     //กลับไปที่หน้า Login
//     Navigator.of(context, rootNavigator: true)
//         .pushNamedAndRemoveUntil('/login_page', (route) => false);
//   }

//   late Map<String, dynamic> imgSlide;
//   Future<Map<String, dynamic>> getDataSlide() async {
//     var url = (Global.urlWeb +
//         'api/app/emergency/restful/?em_user_id=${Global.user_id}&em_app_id=${Global.app_id}&em_category=1');
//     var response = await http.get(Uri.parse(url), headers: {
//       'Authorization':
//           'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//     });

//     if (response.statusCode == 200) {
//       imgSlide = json.decode(response.body);

//       // print(imgSlide['data'].length);
//       return imgSlide;
//     } else {
//       throw Exception('$response.statusCode');
//     }
//   }

//   var em_location = 'ยังไม่ได้เลือก';
//   Future<void> addEmergecy(Map formValues) async {
//     int index = 0;
//     //formValues['name']
//     // print(formValues);
//     try {
//       if (formValues['em_detail'] != null &&
//           formValues['em_phone'] != null &&
//           formValues['em_owner'] != null &&
//           formValues['em_type'] != null) {
//         var url = Uri.parse(Global.urlWeb + 'api/app/emergency/restful/');
//         var request = http.MultipartRequest('POST', url)
//           ..fields['em_app_id'] = Global.app_id
//           ..fields['em_user_id'] = Global.user_id ?? ''
//           ..fields['em_detail'] = formValues['em_detail']
//           ..fields['em_phone'] = formValues['em_phone']
//           ..fields['em_owner'] = formValues['em_owner']
//           ..fields['em_lat'] = '1'
//           ..fields['em_lng'] = '1'
//           ..fields['em_location'] = em_location
//           ..fields['em_category'] = '1'
//           ..fields['em_type'] = formValues['em_type'];

//         Map<String, String> headers = {
//           "Accept": "application/json",
//           "Content-type": "multipart/form-data",
//           "Authorization":
//               'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//         };

//         for (XFile item in formValues['emi_path_name'] ?? []) {
//           request.files.add(
//               await http.MultipartFile.fromPath('emi_path_name[]', item.path));
//           index++;
//         }

//         request.headers.addAll(headers);
//         var res = await request.send();
//         http.Response response = await http.Response.fromStream(res);

//         var feedback = jsonDecode(response.body);

//         if (feedback['data'] == "สำเร็จ") {
//           Alert(
//             context: context,
//             // title: "แจ้งเตือน",
//             type: AlertType.success,
//             desc: '${profilee['data']}',
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "ปิด",
//                   style: TextStyle(color: ThemeBc.white, fontSize: 18),
//                 ),
//                 onPressed: () {},
//                 gradient: LinearGradient(colors: [
//                   Color.fromRGBO(116, 116, 191, 1.0),
//                   Color.fromRGBO(52, 138, 199, 1.0),
//                 ]),
//               )
//             ],
//           ).show();

//           //กลับไปที่หน้า LoginPage
//           // Future.delayed(const Duration(seconds: 5), () {
//           //   // Navigator.pop(context);
//           //    Navigator.pop(context, '/login');
//           // });
//         } else {
//           Alert(
//             context: context,
//             type: AlertType.warning,
//             // title: "แจ้งเตือน",
//             desc: '${profilee['data']}',
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "ปิด",
//                   style: TextStyle(color: ThemeBc.white, fontSize: 18),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 gradient: LinearGradient(colors: [
//                   Color.fromRGBO(116, 116, 191, 1.0),
//                   Color.fromRGBO(52, 138, 199, 1.0),
//                 ]),
//               )
//             ],
//           ).show();
//         }
//       } else {}
//     } catch (e) {
//       // print(e);
//     }
//   }

//   Future getImage() async {
//     //var image = await ImagePicker().getImage(source: ImageSource.gallery);
//     final ImagePicker _picker = ImagePicker();
//     // Pick an image
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       selectedImage = File(image!.path);
//     });
//   }

//   // late GoogleMapController mapController;
//   late String position = 'ยังไม่ได้เลือก';

//   // void _onMapCreated(GoogleMapController controller) {
//   //   mapController = controller;
//   // }

//   // Future<Position> _getLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     return Future.error('Location services are disabled.');
//   //   }

//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }

//   //   userLocation = await Geolocator.getCurrentPosition();
//   //   return userLocation;
//   // }

//   // List<Marker> myMarker = [];
//   @override
//   Widget build(BuildContext context) {
//     Widget warnpage() {
//       return StoreConnector<AppState, Map<String, dynamic>>(
//           distinct: true,
//           converter: (store) => store.state.profileState.profile,
//           builder: (context, profile) {
//             var user_phone = profile['user_phone'] ?? '';
//             var user_firstname = profile['user_firstname'] != null
//                 ? '${profile['user_firstname']} ${profile['user_lastname']}'
//                 : '';

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // const Text('เลือกประเภทการแจ้งเหตุ',
//                     //     style: TextStyle(fontSize: 15)),
//                     // const Divider(),
//                     // const SizedBox(height: 40),
//                     FormBuilder(
//                       key: _fbKey,
//                       initialValue: {
//                         'em_type': '1',
//                         // '2': '-',
//                         'em_phone': user_phone,
//                         'em_detail': '1',
//                         // '5': '',
//                         //  'em_location': '$em_location',
//                         // 'em_lat': '',
//                         // 'em_lng': '',
//                         // 'em_app_id': '1',
//                         'em_owner': '${user_firstname}'
//                       },
//                       autovalidateMode: AutovalidateMode
//                           .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(height: 18),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: secondaryTextColor,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: FormBuilderDropdown(
//                                   name: "em_type",

//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         20.0,
//                                       ),
//                                     ),
//                                     suffixIcon: Icon(Icons.article),
//                                     // labelText: 'เลือกประเภทการแจ้งเหตุ',
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                   ),
//                                   // initialValue: 'Male',
//                                   //allowClear: true,
//                                   hint: Text('เลือกประเภทการแจ้งเหตุ'),

//                                   initialValue: '1',
//                                   items: [
//                                     DropdownMenuItem(
//                                       value: '1',
//                                       child: Text('ผู้ป่วยฉุกเฉิน'),
//                                     ),
//                                     DropdownMenuItem(
//                                         value: '2', child: Text('ไฟฟ้ารั่ว')),
//                                     DropdownMenuItem(
//                                         value: '3', child: Text('ไฟไหม้')),
//                                     DropdownMenuItem(
//                                         value: '4', child: Text('เหตุระเบิด')),
//                                     DropdownMenuItem(
//                                         value: '5', child: Text('อุบัติเหตุ')),
//                                     DropdownMenuItem(
//                                         value: '6', child: Text('อาชญากรรม')),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 18),
//                           // Material(
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: secondaryTextColor,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: FormBuilderTextField(
//                                   name: "em_owner",
//                                   maxLines: 1,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         20.0,
//                                       ),
//                                     ),
//                                     suffixIcon: Icon(Icons.email),
//                                     labelText: 'ชื่อผู้แจ้ง',
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 18),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: secondaryTextColor,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: FormBuilderTextField(
//                                   name: "em_phone",
//                                   maxLines: 1,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         20.0,
//                                       ),
//                                     ),
//                                     suffixIcon: Icon(Icons.phone_android),
//                                     labelText: 'เบอร์โทรศัพท์',
//                                     //   labelStyle: TextStyle(
//                                     //   color: Color(0xFF6200EE),
//                                     // ),
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 18),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: secondaryTextColor,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: FormBuilderTextField(
//                                   name: "em_detail",
//                                   maxLines: 1,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         20.0,
//                                       ),
//                                     ),
//                                     suffixIcon: Icon(Icons.description),
//                                     labelText: 'รายละเอียดเหตุการณ์',
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                   ),
//                                 ),
//                               ),
//                             ), //รายละเอียดเหตุการณ์
//                           ),

//                           SizedBox(height: 18),
//                           // Container(
//                           //   width: 400,
//                           //   height: 300,
//                           //   decoration: BoxDecoration(
//                           //       color: secondaryTextColor,
//                           //       borderRadius: BorderRadius.circular(
//                           //         20,
//                           //       ),
//                           //       boxShadow: [
//                           //         BoxShadow(
//                           //             color: Colors.grey.withOpacity(0.5),
//                           //             offset: Offset(2, 2),
//                           //             blurRadius: 7,
//                           //             spreadRadius: 1.0),
//                           //         BoxShadow(
//                           //             color: Colors.black.withOpacity(0.5),
//                           //             offset: Offset(2, 4),
//                           //             blurRadius: 7.0,
//                           //             spreadRadius: 1.0),
//                           //       ]),
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.all(8.0),
//                           //     child: ListView(
//                           //       children: [
//                           //         Padding(
//                           //           padding: const EdgeInsets.all(5.0),
//                           //           child: Column(
//                           //             crossAxisAlignment: CrossAxisAlignment.start,
//                           //             children: [
//                           //               Text('อัพโหลดรูปภาพ'),
//                           //             ],
//                           //           ),
//                           //         ),
//                           //         Column(
//                           //           crossAxisAlignment: CrossAxisAlignment.start,
//                           //           children: [
//                           //             Padding(
//                           //               padding: const EdgeInsets.all(8.0),
//                           //               child: Container(
//                           //                 decoration: BoxDecoration(
//                           //                     color: ThemeBc.white,
//                           //                     borderRadius: BorderRadius.circular(
//                           //                       20,
//                           //                     ),
//                           //                     boxShadow: []),
//                           //                 width: 350,
//                           //                 height: 240,
//                           //                 child: Padding(
//                           //                   padding: const EdgeInsets.all(8.0),
//                           //                   child: Column(
//                           //                     mainAxisAlignment:
//                           //                         MainAxisAlignment.center,
//                           //                     children: <Widget>[
//                           //                       selectedImage == null
//                           //                           ? IconButton(
//                           //                               icon: Icon(Icons.add_a_photo),
//                           //                               tooltip: 'Show Snackbar',
//                           //                               onPressed: getImage,
//                           //                             )
//                           //                           : Container(
//                           //                               height: 200,
//                           //                               child: ListView(
//                           //                                 children: [
//                           //                                   Container(
//                           //                                       height: 100,
//                           //                                       child: Image.file(
//                           //                                           selectedImage!)),
//                           //                                 ],
//                           //                               ),
//                           //                             ),
//                           //                       // Text(resJson),
//                           //                     ],
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ],
//                           //     ),

//                           //     Container(
//                           //       child: FormBuilderImagePicker(
//                           //         name: 'emi_path_name',
//                           //         iconColor: Colors.black,
//                           //         decoration: InputDecoration(
//                           //           border: OutlineInputBorder(
//                           //             borderRadius: BorderRadius.circular(
//                           //               20.0,
//                           //             ),
//                           //           ),
//                           //           labelText: 'ภาพประกอบเหตุการ',
//                           //           filled: true,
//                           //         ),
//                           //         maxImages: 1,
//                           //       ),
//                           //     ),
//                           // //   ),
//                           // ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: secondaryTextColor,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: FormBuilderImagePicker(
//                                 name: 'emi_path_name',
//                                 displayCustomType: (obj) =>
//                                     obj is ApiImage ? obj.imageUrl : obj,
//                                 iconColor: Colors.black,
//                                 decoration: InputDecoration(
//                                   suffixIconColor: ThemeBc.black,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(
//                                       20.0,
//                                     ),
//                                   ),
//                                   labelText: 'ภาพ',
//                                   fillColor: Colors.white,
//                                   filled: true,
//                                 ),
//                                 maxImages: 5,
//                                 onSaved: (val) {
//                                   print(val);
//                                 },
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 18),

//                           FutureBuilder(
//                               future: _getLocation(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   return Container(
//                                     height: 320,
//                                     child: ListView(
//                                       children: [
//                                         Container(
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 color: secondaryTextColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   20,
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Colors.grey
//                                                           .withOpacity(0.5),
//                                                       offset: Offset(2, 2),
//                                                       blurRadius: 7,
//                                                       spreadRadius: 1.0),
//                                                   BoxShadow(
//                                                       color: Colors.black
//                                                           .withOpacity(0.5),
//                                                       offset: Offset(2, 4),
//                                                       blurRadius: 7.0,
//                                                       spreadRadius: 1.0),
//                                                 ]),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Container(
//                                                 height: 300,
//                                                 child: Column(
//                                                   children: [
//                                                     Flexible(
//                                                         child: FlutterMap(
//                                                       options: MapOptions(
//                                                           center: LatLng(
//                                                               userLocation
//                                                                   .latitude,
//                                                               userLocation
//                                                                   .longitude),
//                                                           zoom: 16),
//                                                       layers: [
//                                                         TileLayerOptions(
//                                                           urlTemplate:
//                                                               "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                                                           subdomains: [
//                                                             'a',
//                                                             'b',
//                                                             'c'
//                                                           ],
//                                                           attributionBuilder:
//                                                               (_) {
//                                                             return Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .end,
//                                                                 children: [
//                                                                   // ElevatedButton.icon(
//                                                                   //   onPressed: () {
//                                                                   //     print('$userLocation');
//                                                                   //     // locn = userLocation.latitude;
//                                                                   //     // locn2 = userLocation
//                                                                   //     //     .longitude; // mapController.animateCamera(CameraUpdate.newLatLngZoom(
//                                                                   //     // //     LatLng(userLocation.latitude, userLocation.longitude),
//                                                                   //     // //     18));
//                                                                   //     showDialog(
//                                                                   //       context: context,
//                                                                   //       builder: (context) {
//                                                                   //         return AlertDialog(
//                                                                   //           content: Text(
//                                                                   //               'ตำแหน่ง !\nละติจูด :// ${locn} ลองจิจูด : ${locn} ตำแหน่งที่คุณเลือก : '),
//                                                                   //         );
//                                                                   //       },
//                                                                   //     );
//                                                                   //   },
//                                                                   //   icon: Icon(Icons.gps_fixed),
//                                                                   //   label: Text('ตำแหน่งของคุณ'),
//                                                                   //   style: ElevatedButton.styleFrom(
//                                                                   //     primary: ThemeBc.background,
//                                                                   //     onPrimary: Colors.white,
//                                                                   //     elevation: 30,
//                                                                   //     shape: RoundedRectangleBorder(
//                                                                   //         borderRadius: BorderRadius.all(
//                                                                   //             Radius.circular(40))),
//                                                                   //   ),
//                                                                   // ),
//                                                                   Container(
//                                                                     decoration:
//                                                                         BoxDecoration(
//                                                                       color:
//                                                                           secondaryTextColor,
//                                                                       borderRadius:
//                                                                           BorderRadius
//                                                                               .circular(
//                                                                         20,
//                                                                       ),
//                                                                     ),
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Text(
//                                                                         "เทศบาลมหาสารคาม",
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               20.0,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           // backgroundColor: Colors.black45,
//                                                                           color:
//                                                                               Colors.black,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             );
//                                                           },
//                                                         ),
//                                                         MarkerLayerOptions(
//                                                             markers: [
//                                                               Marker(
//                                                                 point: LatLng(
//                                                                     userLocation
//                                                                         .latitude,
//                                                                     userLocation
//                                                                         .longitude),
//                                                                 builder: (ctx) =>
//                                                                     IconButton(
//                                                                   icon: Icon(Icons
//                                                                       .my_location),
//                                                                   tooltip:
//                                                                       'Show Snackbar',
//                                                                   onPressed:
//                                                                       () {
//                                                                     showDialog(
//                                                                       context:
//                                                                           context,
//                                                                       builder:
//                                                                           (context) {
//                                                                         return AlertDialog(
//                                                                           content:
//                                                                               Text('ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} '),
//                                                                         );
//                                                                       },
//                                                                     );
//                                                                   },
//                                                                 ),
//                                                               )
//                                                             ]),
//                                                       ],
//                                                     ))
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                   // Text('${userLocation.latitude} ${userLocation.longitude}');
//                                 } else {
//                                   return Center(
//                                     child: Column(
//                                       children: <Widget>[
//                                         CircularProgressIndicator(),
//                                       ],
//                                     ),
//                                   );
//                                 }
//                                 return Container();
//                               }),

//                           SizedBox(height: 10),
//                           Container(
//                               width: 400,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                   color: secondaryTextColor,
//                                   borderRadius: BorderRadius.circular(
//                                     20,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         offset: Offset(2, 2),
//                                         blurRadius: 7,
//                                         spreadRadius: 1.0),
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.5),
//                                         offset: Offset(2, 4),
//                                         blurRadius: 7.0,
//                                         spreadRadius: 1.0),
//                                   ]),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'ตำแหน่ง ! \nตำแหน่งที่คุณเลือก : ',
//                                       style: TextStyle(
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.bold,
//                                         // backgroundColor: Colors.black45,
//                                         color: ThemeBc.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )),

//                           // ElevatedButton.icon(
//                           //   onPressed: () {
//                           //     // mapController.animateCamera(CameraUpdate.newLatLngZoom(
//                           //     //     LatLng(userLocation.latitude, userLocation.longitude),
//                           //     //     18));
//                           //     showDialog(
//                           //       context: context,
//                           //       builder: (context) {
//                           //         return AlertDialog(
//                           //           content: Text(
//                           //               'ตำแหน่ง !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} ตำแหน่งที่คุณเลือก : $position'),
//                           //         );
//                           //       },
//                           //     );
//                           //   },
//                           //   icon: Icon(Icons.gps_fixed),
//                           //   label: Text('ตำแหน่งของคุณ'),
//                           //   style: ElevatedButton.styleFrom(
//                           //     primary: ThemeBc.background,
//                           //     onPrimary: Colors.white,
//                           //     elevation: 30,
//                           //     shape: RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.all(Radius.circular(40))),
//                           //   ),
//                           // ),
//                           SizedBox(height: 18),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 0),
//                             margin: EdgeInsets.only(top: 0, bottom: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CustomButton(
//                                   title: 'แจ้งเหตุฉุกเฉิน',
//                                   onPressed: () {
//                                     if (_fbKey.currentState!
//                                         .saveAndValidate()) {
//                                       print(_fbKey.currentState!.value);
//                                       addEmergecy(_fbKey.currentState!.value);
//                                     }
//                                   },
//                                   colorButton: ThemeBc.background,
//                                   textStyle: secondaryTextStyle.copyWith(
//                                       fontWeight: medium, fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // NeumorphicButton(
//                           //   style: const NeumorphicStyle(
//                           //     shape: NeumorphicShape.flat,
//                           //     color: ThemeBc.white,
//                           //   ),
//                           //   child: FormBuilderDropdown(
//                           //     name: 'em_type',
//                           //     decoration: InputDecoration(
//                           //       labelText: 'เลือกประเภทการแจ้งเหตุ',
//                           //     ),
//                           //     // initialValue: 'Male',
//                           //     allowClear: true,
//                           //     hint: Text('เลือกประเภทการแจ้งเหตุ'),
//                           //     validator: RequiredValidator(
//                           //         errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
//                           //     // initialValue: '1',
//                           //     items: [
//                           //       DropdownMenuItem(
//                           //           value: '1', child: Text('ผู้ป่วยฉุกเฉิน')),
//                           //       DropdownMenuItem(
//                           //           value: '2', child: Text('ไฟฟ้ารั่ว')),
//                           //       DropdownMenuItem(
//                           //           value: '3', child: Text('ไฟไหม้')),
//                           //       DropdownMenuItem(
//                           //           value: '4', child: Text('เหตุระเบิด')),
//                           //       DropdownMenuItem(
//                           //           value: '5', child: Text('อุบัติเหตุ')),
//                           //       DropdownMenuItem(
//                           //           value: '6', child: Text('อาชญากรรม')),
//                           //     ],
//                           //   ),
//                           // ),

//                           // NeumorphicButton(
//                           //   style: const NeumorphicStyle(
//                           //     shape: NeumorphicShape.flat,
//                           //     color: ThemeBc.white,
//                           //   ),
//                           //   child: FormBuilderTextField(
//                           //     // initialValue: '1@gmail.com',
//                           //     name: "em_owner",
//                           //     maxLines: 1,
//                           //     keyboardType: TextInputType.text,
//                           //     decoration: const InputDecoration(
//                           //       helperText: 'ชื่อผู้แจ้ง',
//                           //       // suffixIcon: Icon(
//                           //       //   Icons.check_circle,
//                           //       // ),
//                           //       enabledBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(color: ThemeBc.black),
//                           //       ),
//                           //       // hintText: 'ชื่อผู้แจ้ง',
//                           //       filled: true,
//                           //       fillColor: ThemeBc.white,
//                           //     ),
//                           //     validator: MultiValidator([
//                           //       RequiredValidator(
//                           //           errorText: "ป้อนข้อมูลชื่อด้วย"),
//                           //     ]),
//                           //   ),
//                           // ),
//                           // const SizedBox(height: 20),
//                           // NeumorphicButton(
//                           //   style: const NeumorphicStyle(
//                           //     shape: NeumorphicShape.flat,
//                           //     color: ThemeBc.white,
//                           //   ),
//                           //   child: FormBuilderTextField(
//                           //     // initialValue: '1@gmail.com',
//                           //     name: "em_phone",
//                           //     maxLines: 1,
//                           //     keyboardType: TextInputType.text,
//                           //     decoration: InputDecoration(
//                           //       helperText: 'เบอร์โทรศัพท์',
//                           //       suffixIcon: const Icon(
//                           //         Icons.check_circle,
//                           //       ),
//                           //       enabledBorder: const UnderlineInputBorder(
//                           //         borderSide: BorderSide(color: ThemeBc.black),
//                           //       ),
//                           //       // hintText: 'เบอร์โทรศัพท์',
//                           //       filled: true,
//                           //       fillColor: ThemeBc.white,
//                           //     ),
//                           //     validator: MultiValidator([
//                           //       RequiredValidator(
//                           //           errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
//                           //     ]),
//                           //   ),
//                           // ),
//                           // const SizedBox(height: 20),
//                           // NeumorphicButton(
//                           //   style: const NeumorphicStyle(
//                           //     shape: NeumorphicShape.flat,
//                           //     color: ThemeBc.white,
//                           //   ),
//                           //   child: FormBuilderTextField(
//                           //     // initialValue: '1@gmail.com',
//                           //     name: "em_detail",
//                           //     maxLines: 1,
//                           //     keyboardType: TextInputType.emailAddress,
//                           //     decoration: InputDecoration(
//                           //       helperText: 'รายละเอียดเหตุการณ์',
//                           //       suffixIcon: const Icon(
//                           //         Icons.check_circle,
//                           //       ),
//                           //       enabledBorder: const UnderlineInputBorder(
//                           //         borderSide: BorderSide(color: ThemeBc.black),
//                           //       ),
//                           //       // hintText: 'อีเมล',
//                           //       filled: true,
//                           //       fillColor: ThemeBc.white,
//                           //     ),
//                           //     validator: MultiValidator([
//                           //       RequiredValidator(
//                           //           errorText: "ป้อนข้อมูลอีเมลด้วย"),
//                           //       // EmailValidator(errorText: "รูปแบบอีเมล์ไม่ถูกต้อง"),
//                           //     ]),
//                           //   ),
//                           // ),
//                           // const SizedBox(height: 20),

//                           // FormBuilderImagePicker(
//                           //   name: 'emi_path_name',
//                           //   displayCustomType: (obj) =>
//                           //       obj is ApiImage ? obj.imageUrl : obj,
//                           //   decoration: const InputDecoration(
//                           //       labelText: 'ภาพเหตุการณ์'),
//                           //   maxImages: 5,
//                           //   onSaved: (val) {
//                           //     print(val);
//                           //   },
//                           // ),

//                           // const SizedBox(height: 20),

//                           // // Container(
//                           // //   padding: EdgeInsets.symmetric(horizontal: 0),
//                           // //   margin: EdgeInsets.only(
//                           // //     top: 0,
//                           // //   ),
//                           // //   height: 300.0,
//                           // //   child: FutureBuilder(
//                           // //     future: getLocation(),
//                           // //     builder: (BuildContext context,
//                           // //         AsyncSnapshot snapshot) {
//                           // //       if (snapshot.hasData) {
//                           // //         _handletap(LatLng point) {
//                           // //           em_location = point.toString();

//                           // //           setState(() {
//                           // //             myMarker = [];
//                           // //             myMarker.add(Marker(
//                           // //               markerId: MarkerId(point.toString()),
//                           // //               position: point,
//                           // //               infoWindow: InfoWindow(
//                           // //                 title: 'ตำแหน่งปัจจุบัน',
//                           // //               ),

//                           // //             ));
//                           // //           });
//                           // //           return position;
//                           // //         }

//                           // //         return Column(
//                           // //           children: [
//                           // //             Container(
//                           // //               height: 280,
//                           // //               child: GoogleMap(
//                           // //                 markers: Set.from(myMarker),
//                           // //                 onTap: _handletap,
//                           // //                 mapType: MapType.normal,
//                           // //                 onMapCreated: onMapCreated(),
//                           // //                 myLocationEnabled: true,
//                           // //                 initialCameraPosition: CameraPosition(
//                           // //                     target: LatLng(
//                           // //                         userLocation.latitude,
//                           // //                         userLocation.longitude),
//                           // //                     zoom: 15),
//                           // //               ),
//                           // //             ),
//                           // //           ],
//                           // //         );
//                           // //       } else {
//                           // //         return Center(
//                           // //           child: Column(
//                           // //             mainAxisAlignment:
//                           // //                 MainAxisAlignment.center,
//                           // //             children: <Widget>[
//                           // //               CircularProgressIndicator(),
//                           // //             ],
//                           // //           ),
//                           // //         );
//                           // //       }
//                           // //     },
//                           // //   ),
//                           // // ),

//                           // const SizedBox(height: 10),
//                           // //  mainMap(),
//                           // Text('จุดเกิดเหตุ',
//                           //     style: TextStyle(
//                           //         fontSize: 12, color: ThemeBc.black)),
//                           // const SizedBox(height: 5),
//                           // NeumorphicButton(
//                           //   style: const NeumorphicStyle(
//                           //     shape: NeumorphicShape.flat,
//                           //     color: ThemeBc.white,
//                           //   ),
//                           //   child: Text(em_location),
//                           // ),
//                           // const SizedBox(height: 20),

//                           // // const Text('รูปภาพเหตุการณ์',
//                           // //     style: TextStyle(fontSize: 15)),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             label: const Text('แจ้งเหตุฉุกเฉิน'),
//                             icon: const Icon(Icons.add_alert_sharp),
//                             style: ElevatedButton.styleFrom(
//                               primary: ThemeBc.green,
//                               //side: BorderSide(color: Colors.red, width: 5),
//                               textStyle: const TextStyle(fontSize: 15),
//                               padding: const EdgeInsets.all(15),
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                             ),
//                             onPressed: () {
//                               if (_fbKey.currentState!.saveAndValidate()) {
//                                 print(_fbKey.currentState!.value);
//                                 addEmergecy(_fbKey.currentState!.value);
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           });
//     }

//     Widget warndetaikpage() {
//       return Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [ThemeBc.white, ThemeBc.white],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft),
//         ),
//         child: Container(
//           width: 1000,
//           height: 1000,
//           child: FutureBuilder<Map<String, dynamic>>(
//             future: getDataSlide(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!['data'].length,
//                   itemBuilder: (context, index) {
//                     var datanill = snapshot.data!['data'];
//                     print(snapshot.data!['data'].length);
//                     var em_detaail;
//                     if (datanill == 'ไม่พบข้อมูล') {
//                       em_detaail = 'ไม่พบข้อมูล';
//                       return Text('');
//                     } else {
//                       return Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: secondaryTextColor,
//                                   borderRadius: BorderRadius.circular(
//                                     30,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         offset: Offset(2, 2),
//                                         blurRadius: 7,
//                                         spreadRadius: 1.0),
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.5),
//                                         offset: Offset(2, 4),
//                                         blurRadius: 7.0,
//                                         spreadRadius: 1.0),
//                                   ]),
//                               height: 80,
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     // mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         child: Column(
//                                           children: [
//                                             ListTile(
//                                               title: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(height: 10),
//                                                   Text(
//                                                     '${snapshot.data!['data'][index]['em_type']}',
//                                                     style: primaryTextStyle
//                                                         .copyWith(
//                                                             fontSize: 18,
//                                                             fontWeight: medium),
//                                                   ),
//                                                 ],
//                                               ),
//                                               trailing: Container(
//                                                 width: 80,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(0.0),
//                                                   child: Row(
//                                                     children: [
//                                                       //         .callNumber(number);},

//                                                       SizedBox(width: 5),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(3),
//                                                         child: Container(
//                                                           height: 40,
//                                                           child: ElevatedButton
//                                                               .icon(
//                                                             onPressed: () =>
//                                                                 Navigator.pushNamed(
//                                                                     context,
//                                                                     '/composedetail_page',
//                                                                     arguments: {
//                                                                   'em_owner': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_owner'],
//                                                                   'em_detail': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_detail'],
//                                                                   'em_images': snapshot.data!['data'][index]
//                                                                               [
//                                                                               'em_images'] !=
//                                                                           null
//                                                                       ? Global.domainImage +
//                                                                           snapshot.data!['data'][index]['em_images'][0]
//                                                                               [
//                                                                               'emi_path_name']
//                                                                       : '${Global.networkImage}',
//                                                                   'em_phone': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_phone'],
//                                                                   'em_lat': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_lat'],
//                                                                   'em_lng': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_lng'],
//                                                                   'em_location':
//                                                                       snapshot.data!['data']
//                                                                               [
//                                                                               index]
//                                                                           [
//                                                                           'em_location'],
//                                                                   'em_type': snapshot
//                                                                               .data!['data']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'em_type'],
//                                                                 }),
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .maps_home_work,
//                                                               color:
//                                                                   Colors.pink,
//                                                               size: 30,
//                                                             ),
//                                                             label: Text(''),
//                                                             style:
//                                                                 ElevatedButton
//                                                                     .styleFrom(
//                                                               primary:
//                                                                   Colors.orange,
//                                                               elevation: 10,
//                                                               shape: RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius.all(
//                                                                           Radius.circular(
//                                                                               20))),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                     child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
//               }

//               return Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: ThemeBc.white, //change your color here
//         ),
//         shadowColor: ThemeBc.white,
//         foregroundColor: ThemeBc.white,
//         backgroundColor: ThemeBc.background,
//         title: Center(child: const Text('แจ้งเหตุฉุกเฉิน')),
//         actions: <Widget>[
//           IconButton(
//             icon: Image.asset('assets/logo.png', scale: 15),
//             tooltip: 'Show Snackbar',
//             onPressed: () {
//               if (_fbKey.currentState!.saveAndValidate()) {
//                 print(_fbKey.currentState!.value);
//                 addEmergecy(_fbKey.currentState!.value);
//               }
//             },
//           ),
//         ],
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _tabController,
//           // indicator: PointTabIndicator(
//           //   position: PointTabIndicatorPosition.bottom,
//           //   color: white,
//           //   insets: EdgeInsets.only(bottom: 6),
//           // ),
//           tabs: tabList.map((item) {
//             return Tab(
//               text: item,
//             );
//           }).toList(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.pinkAccent, Colors.orangeAccent],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft),
//         ),
//         child: TabBarView(
//           controller: _tabController,
//           children: tabList.map((item) {
//             if (item == 'แจ้งเหตุฉุกเฉิน') {
//               return warnpage();
//             } else {
//               return warndetaikpage();
//             }

//             // print(item);
//             // return Center(child: Text(item));
//           }).toList(),
//         ),
//       ),
//     );
//     /* Widget imageSplash() {
//       return Container();
//       /* return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               child: Text(''),
//             ),
//             Material(
//               elevation: 18,
//               shadowColor: Colors.grey.withOpacity(0.5),
//               child: TextField(
//                 decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.account_box_outlined),
//                   labelText: 'ชื่อผู้แจ้ง',
//                   fillCsEdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               child: Text(''),
//             ),
//             Material(
//               elevation: 18,
//               shadowColor: Colors.grey.withOpacity(0.5),
//               child: TextField(
//                 decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.phone),
//                   labelText: 'เบอร์โทรสัพ',
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               child: Text(''),
//             ),
//             Material(
//               elevation: 18,
//               shadowColor: Colors.grey.withOpacity(0.5),
//               child: TextField(
//                 decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.align_horizontal_left),
//                   labelText: 'รายละเอียดเหตุการณ์',
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );*/
//     }

//     Widget textimport() {
//       return FormBuilder(
//         child: SafeArea(
//           child: Padding(
//             padding:  EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                       child: Text(''),
//                     ),
//                   ],
//                 ),
//                 Material(
//                   elevation: 18,
//                   shadowColor: Colors.grey.withOpacity(0.5),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.account_box_outlined),
//                       labelText: 'ชื่อผู้แจ้ง',
//                       fillColor: Colors.white,
//                       filled: true,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                   child: Text(''),
//                 ),
//                 Material(
//                   elevation: 18,
//                   shadowColor: Colors.grey.withOpacity(0.5),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.phone),
//                       labelText: 'เบอร์โทรสัพ',
//                       fillColor: Colors.white,
//                       filled: true,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                   child: Text(''),
//                 ),
//                 Material(
//                   elevation: 18,
//                   shadowColor: Colors.grey.withOpacity(0.5),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.align_horizontal_left),
//                       labelText: 'รายละเอียดเหตุการณ์',
//                       fillColor: Colors.white,
//                       filled: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     Widget titleMenus() {
//       return Container(
//         margin: EdgeInsets.only(top: 30, left: defaultMargin),
//         child: Text(
//           'เลือกประเภทการแจ้งเหตุ',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//       );
//     }

//     Widget balanceCard() {
//       return FormBuilder(
//         child: SafeArea(
//           child: BottomAppBar(
//             shape: CircularNotchedRectangle(),
//             notchMargin: 5,
//             clipBehavior: Clip.antiAlias,
//             child: Container(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     SizedBox(width: defaultMargin),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/01.png',
//                       titleMenus: 'ผู้ป่วยฉุกเฉิน',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                     SizedBox(width: 15),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/02.png',
//                       titleMenus: 'ไฟฟ้ารั่ว',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                     SizedBox(width: 15),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/03.png',
//                       titleMenus: 'ไฟไหม้',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                     SizedBox(width: 15),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/04.png',
//                       titleMenus: 'เหตุระเบิด',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                     SizedBox(width: 15),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/05.png',
//                       titleMenus: 'อุบัติเหตุ',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                     SizedBox(width: 15),
//                     MenusCustom(
//                       iconMenus: 'assets/warn/06.png',
//                       titleMenus: 'อาชญากรรม',
//                       pathName: '/warn',
//                       titleMenus1: '',
//                       titleMenus2: '',
//                     ),
//                     SizedBox(width: defaultMargin),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     Widget button() {
//       return Container(
//         height: 80,
//         margin: EdgeInsets.only(top: 20, bottom: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomButtonmenu(
//               title: 'แจ้งเหตุฉุกเฉิน',
//               onPressed: () => Navigator.pushNamed(context, '/warn'),
//               colorButton: buttonGreyColor,
//               textStyle:
//                   secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
//             ),
//             SizedBox(width: 10),
//             CustomButtonmenu(
//               title: 'เหตุฉุกเฉินของท่าน',
//               onPressed: () => Navigator.pushNamed(context, '/warn'),
//               colorButton: primaryColor,
//               textStyle:
//                   secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
//             ),
//           ],
//         ),
//       );
//     }

//     Widget buttonimagee() {
//       return FormBuilder(
//         child: Container(
//           margin: EdgeInsets.only(top: 10),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 SizedBox(width: defaultMargin),
//                 MenusCustom(
//                   iconMenus: 'assets/warn/07.png',
//                   titleMenus: '',
//                   pathName: '/message',
//                   titleMenus1: '',
//                   titleMenus2: '',
//                 ),
//                 SizedBox(width: defaultMargin),
//                 SizedBox(width: 15),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//    /* Widget map() {
//       Future<Position> _getLocation() async {
//         bool serviceEnabled;
//         LocationPermission permission;

//         serviceEnabled = await Geolocator.isLocationServiceEnabled();
//         if (!serviceEnabled) {
//           return Future.error('Location services are disabled.');
//         }

//         permission = await Geolocator.checkPermission();
//         if (permission == LocationPermission.denied) {
//           permission = await Geolocator.requestPermission();
//           if (permission == LocationPermission.denied) {
//             return Future.error('Location permissions are denied');
//           }
//         }

//         if (permission == LocationPermission.deniedForever) {
//           return Future.error(
//               'Location permissions are permanently denied, we cannot request permissions.');
//         }

//         userLocation = await Geolocator.getCurrentPosition();
//         return userLocation;
//       }

//       LatLng latLng = LatLng(16.44544, 102.82839);
//       CameraPosition cameraPosition = CameraPosition(
//         target: latLng,
//         zoom: 16.0,
//       );
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: defaultMargin),
//         margin: EdgeInsets.only(
//           top: 0,
//         ),
//         height: 300.0,
//         child: FutureBuilder(
//           future: _getLocation(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return GoogleMap(
//                 mapType: MapType.normal,
//                 onMapCreated: _onMapCreated,
//                 myLocationEnabled: true,
//                 initialCameraPosition: CameraPosition(
//                     target:
//                         LatLng(userLocation.latitude, userLocation.longitude),
//                     zoom: 15),
//               );
//             } else {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     CircularProgressIndicator(),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       );
//     }

//     Widget textphotoevent() {
//       return Container(
//         margin: EdgeInsets.only(top: 30, left: defaultMargin),
//         child: Text(
//           'ภาพเหตุการณ์',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//       );
//     }

//     Widget textscene() {
//       return FormBuilder(
//         child: Container(
//             margin: EdgeInsets.only(
//               top: 10,
//             ),
//             padding: EdgeInsets.symmetric(horizontal: defaultMargin),
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                       hintText: "เพิ่มเติม",
//                       labelText: "จุดเกิดเหตุ",
//                       labelStyle: TextStyle(fontSize: 18, color: Colors.black),
//                       border: OutlineInputBorder()),
//                   keyboardType: TextInputType.emailAddress,
//                   obscureText: false,
//                   maxLength: 100,
//                   maxLines: 2,
//                 ),
//               ],
//             )),
//       );
//     }

//     Widget button1() {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: defaultMargin),
//         margin: EdgeInsets.only(top: 20, bottom: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomButton(
//               title: 'แจ้งเหตุฉุกเฉิน',
//               onPressed: () => Navigator.pushNamed(context, '/warn'),
//               colorButton: buttonGreyColor,
//               textStyle:
//                   secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
//             ),
//           ],
//         ),
//       );
//     }*/*/
//   }
// }

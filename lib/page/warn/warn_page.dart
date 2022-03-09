import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:cctv_tun/page/profile/app/app_reducer.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/widgets/custom_buttonn.dart';
import 'package:cctv_tun/widgets/text_FormBuilderField.dart';
import 'package:cctv_tun/widgets/warn_api.dart';

import 'package:cctv_tun/widgets/warn_compose_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
import 'dart:convert';

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

class _warn_page extends State<warn_page> with SingleTickerProviderStateMixin {
  var latt;
  var lon;
  String lonposition = '';
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

  // Future<void> loginSocial(Map formValues) async {
  //   print(formValues);
  //   // print(formValues);
  //   try {
  //     var url =
  //         'https://api.longdo.com/map/services/address?key=d295e0ab6dd9c9cc70753353e385c6c5&lon=${userLocation.longitude}&lat=${userLocation.longitude}';
  //     var response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         "Accept": "application/json",
  //       },
  //       // body: json.encode({
  //       //   "key": 'd295e0ab6dd9c9cc70753353e385c6c5',
  //       //   "lon": userLocation.longitude,
  //       //   "lat": userLocation.latitude,
  //       // })
  //     );

  //     // if (err['error']) {em_status

  //   } catch (e) {
  //     return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return warn_api(
  //           title: 'เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง',
  //           title2: '',
  //         );
  //       },
  //     );
  //   }
  // }
  // Future<Map<String, dynamic>> mapdata() async {
  //   var url =
  //       ('https://api.longdo.com/map/services/address?key=d295e0ab6dd9c9cc70753353e385c6c5&lon=103.28893031327057&lat=16.212232692055206');
  //   var response = await http.get(Uri.parse(url), headers: {
  //     "Accept": "application/json",
  //   });

  //   if (response.statusCode == 200) {
  //     imgSlide = json.decode(response.body);
  //     print(imgSlide);
  //     print(latt);
  //     print(lon);
  //     // print(imgSlide['data'].length);
  //     return imgSlide;
  //   } else {
  //     throw Exception('$response.statusCode');
  //   }
  // }

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

    // mapdata();
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
          ..fields['em_lat'] = latt
          ..fields['em_lng'] = lon
          ..fields['em_location'] = em_location
          ..fields['em_category'] = '1'
          ..fields['em_type'] = formValues['em_type']
          ..fields['em_country'] = '$_country'
          ..fields['em_geocode'] = '$_geocode'
          ..fields['em_province'] = '$_province'
          ..fields['em_district'] = '$_district'
          ..fields['em_subdistrict'] = '$_subdistrict'
          ..fields['em_postcode'] = '$_postcode'
          ..fields['em_elevation'] = '$_elevation'
          ..fields['em_road'] = '$_road';

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
        print(feedback['data']);
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
                title: '${feedback['data']}',
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
    } catch (e) {}
  }

  var _country;
  var _geocode;
  var _province;

  var _district;
  var _subdistrict;
  var _postcode;
  var _elevation;
  var _road;
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

                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.app_white_color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                child: FormBuilderDropdown(
                                  name: 'em_type',
                                  decoration: InputDecoration(
                                    labelText: 'เลือกประเภทการแจ้งเหตุ',
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

                          // NeumorphicButton(
                          //   style: const NeumorphicStyle(
                          //     shape: NeumorphicShape.flat,
                          //     color: ThemeBc.app_white_color,
                          //   ),
                          //   child: FormBuilderTextField(
                          //     name: "",
                          //     maxLines: 1,
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       // labelText: 'Email',
                          //       hintText: 'เบอร์โทรศัพท์',
                          //       filled: true,
                          //       fillColor: ThemeBc.app_white_color,
                          //     ),
                          //     validator: MultiValidator([
                          //       RequiredValidator(
                          //           errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
                          //       MinLengthValidator(10,
                          //           errorText:
                          //               "เบอร์โทรศัพท์ต้อง 10 ตัวอักษรขึ้นไป"),
                          //     ]),
                          //   ),
                          // ),

                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.app_white_color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  Container(
                                    child: FormBuilderTextField(
                                      name: "em_owner",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'ชื่อผู้แจ้ง',
                                        hintText: 'ชื่อผู้แจ้ง',
                                        // filled: true,
                                        fillColor: ThemeBc.app_white_color,
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "ป้อนชื่อผู้แจ้ง"),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.app_white_color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  Container(
                                    child: FormBuilderTextField(
                                      name: "em_phone",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'เบอร์โทรศัพท์',
                                        hintText: 'เบอร์โทรศัพท์',
                                        // filled: true,
                                        fillColor: ThemeBc.app_white_color,
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "ป้อนเบอร์โทรศัพท์ผ่าน"),
                                        MinLengthValidator(10,
                                            errorText:
                                                "เบอร์โทรศัพท์ต้อง 10 ตัวอักษรขึ้นไป"),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.app_white_color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  Container(
                                    child: FormBuilderTextField(
                                      name: "em_detail",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'รายละเอียดเหตุการณ์',
                                        hintText: 'รายละเอียดเหตุการณ์',
                                        fillColor: ThemeBc.app_white_color,
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "ป้อนรายละเอียดเหตุการณ์"),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // FormBuilderFieldText(
                          //     name: 'em_phone',
                          //     labelText: 'เบอร์โทรศัพท์',
                          //     icon: Icons.safety_divider,
                          //     initialValue: ''),

                          SizedBox(height: 18),

                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.app_white_color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FormBuilderImagePicker(
                                name: 'emi_path_name',
                                displayCustomType: (obj) =>
                                    obj is ApiImage ? obj.imageUrl : obj,
                                iconColor: Colors.black,
                                decoration: InputDecoration(
                                  suffixIconColor: ThemeBc.black,
                                  // border: OutlineInputBorder(),
                                  labelText: 'ภาพเหตุการณ์',
                                  fillColor: Colors.white,
                                ),
                                maxImages: 5,
                                onSaved: (val) {
                                  print(val);
                                },
                              ),
                            ),
                          ),

                          // Text('$lon'),
                          SizedBox(height: 18),
                          FutureBuilder(
                              future: _getLocation(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Future<Map<String, dynamic>> mapdata() async {
                                    var url =
                                        ('https://api.longdo.com/map/services/address?key=d295e0ab6dd9c9cc70753353e385c6c5&lon=$lon&lat=$latt');
                                    var response = await http
                                        .get(Uri.parse(url), headers: {
                                      "Accept": "application/json",
                                    });

                                    if (response.statusCode == 200) {
                                      imgSlide = json.decode(response.body);
                                      print(imgSlide);
                                      print(latt);
                                      print(lon);
                                      // print(imgSlide['data'].length);
                                      return imgSlide;
                                    } else {
                                      throw Exception('$response.statusCode');
                                    }
                                  }

                                  latt = '${userLocation.latitude}';
                                  lon = '${userLocation.longitude}';
                                  return Container(
                                    height: 600,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: NeumorphicButton(
                                            style: const NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              color: ThemeBc.app_white_color,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                height: 350,
                                                child: Column(
                                                  children: [
                                                    Flexible(
                                                        child: FlutterMap(
                                                      options: MapOptions(
                                                          onTap: (tapPosition,
                                                              poss) async {
                                                            setState(() {
                                                              point = poss;
                                                            });
                                                          },
                                                          center: LatLng(
                                                              userLocation
                                                                  .latitude,
                                                              userLocation
                                                                  .longitude),
                                                          zoom: 13),
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
                                                                children: [],
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
                                                                          backgroundColor:
                                                                              ThemeBc.app_white_color,
                                                                          content:
                                                                              Container(
                                                                            height:
                                                                                100,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  'ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} ',
                                                                                  style: GoogleFonts.sarabun(
                                                                                    textStyle: TextStyle(
                                                                                      color: ThemeBc.app_textblack_color,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontSize: 17,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ]),
                                                      ],
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          '      จุดเกิดเหตุ ',
                                          style: GoogleFonts.sarabun(
                                            textStyle: TextStyle(
                                              color:
                                                  ThemeBc.app_textblack_color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        NeumorphicButton(
                                          style: const NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            color: ThemeBc.app_white_color,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ThemeBc.app_grey_color,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            height: 150,
                                            child: FutureBuilder<
                                                Map<String, dynamic>>(
                                              future: mapdata(),
                                              builder: (context, snapshot) {
                                                // _road =
                                                //     profile['road'];
                                                if (snapshot.hasData) {
                                                  _country =
                                                      snapshot.data!['country'];
                                                  _district = snapshot
                                                          .data!['district'] ??
                                                      '';
                                                  _elevation = snapshot
                                                          .data!['elevation'] ??
                                                      '';
                                                  _subdistrict = snapshot.data![
                                                          'subdistrict'] ??
                                                      '';

                                                  _geocode = snapshot
                                                          .data!['geocode'] ??
                                                      '';
                                                  _postcode = snapshot
                                                          .data!['postcode'] ??
                                                      '';
                                                  _province = snapshot
                                                          .data!['province'] ??
                                                      '';
                                                  _road =
                                                      snapshot.data!['road'] ??
                                                          '';
                                                  return Column(
                                                    children: [
                                                      Container(
                                                          width: 400,
                                                          height: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${snapshot.data!['country'] ?? ''} ${snapshot.data!['province'] ?? ''} ${snapshot.data!['district'] ?? ''} ${snapshot.data!['subdistrict'] ?? ''} ',
                                                                      style: GoogleFonts
                                                                          .sarabun(
                                                                        textStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              ThemeBc.app_textblack_color,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  );
                                                  // Text('${snapshot.data!['country']}');
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                                                }

                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  // Text('${userLocation.latitude} ${userLocation.longitude}');
                                } else {
                                  return Center(
                                      child: SpinKitThreeInOut(
                                    color: ThemeBc.app_linear_on,
                                  ));
                                }
                                return Container();
                              }),

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
                                  colorButton: ThemeBc.app_linear_on,
                                  textStyle: GoogleFonts.sarabun(
                                    textStyle: TextStyle(
                                      color: ThemeBc.app_textwhite_color,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
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
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!['data'].length,
                    itemBuilder: (context, index) {
                      var datanill = snapshot.data!['data'];
                      var status = snapshot.data!['data'][index]['em_status'];
                      // if (status == '1') {
                      //   status = "รอรับเรื่อง";
                      // }
                      // if (status == '2') {
                      //   status = "รับเรื่องแล้ว";
                      // }
                      // if (status == '3') {
                      //   status = "ตรวจสอบแล้ว";
                      // }
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
                                name02:
                                    '${snapshot.data!['data'][index]['em_detail']}',
                                name:
                                    '${snapshot.data!['data'][index]['emt_name'] ?? '-'}',
                                // name:
                                //     '${snapshot.data!['data'][index]['em_detail']}',
                                onPressed: () => Navigator.pushNamed(
                                    context, '/warndetail_page',
                                    arguments: {
                                      'em_status': status,
                                      'em_owner': snapshot.data!['data'][index]
                                          ['em_owner'],
                                      'em_detail': snapshot.data!['data'][index]
                                          ['em_detail'],
                                      'emt_name': snapshot.data!['data'][index]
                                          ['emt_name'],
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

              return Center(
                  child: SpinKitThreeInOut(
                color: ThemeBc.app_linear_on,
              ));
            },
          ),
        ),
      );
    }

    return Scaffold(
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.app_white_color, //change your color here
        ),
        foregroundColor: ThemeBc.app_white_color,
        backgroundColor: ThemeBc.app_theme_color,
        title: LocaleText(
          'แจ้งเหตุฉุกเฉิน',
          style: GoogleFonts.sarabun(
            textStyle: TextStyle(
              color: ThemeBc.app_textwhite_color,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: ThemeBc.app_linear_on,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {},
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
          gradient: LinearGradient(colors: [
            ThemeBc.app_white_color,
            ThemeBc.app_white_color,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
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

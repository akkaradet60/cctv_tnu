// import 'package:flutter/cupertino.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:smartcity_nt_mobile/global.dart';
// import 'package:smartcity_nt_mobile/redux/app_reducer.dart';
// import 'package:smartcity_nt_mobile/style/global.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

//pic

import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

// import 'package:google_place/google_place.dart';
class EmergecyPage extends StatefulWidget {
  @override
  _EmergecyPageState createState() => _EmergecyPageState();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _EmergecyPageState extends State<EmergecyPage>
    with SingleTickerProviderStateMixin {
  final tabList = ['แจ้งเหตุฉุกเฉิน', 'เหตุฉุกเฉินของท่าน'];
  var em_location = 'ยังไม่ได้เลือก';
  late TabController _tabController;

  double? lat, lng;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
    // findLatLng();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<void> addEmergecy(Map formValues) async {
    int index = 0;

    try {
      if (formValues['em_detail'] != null &&
          formValues['em_phone'] != null &&
          formValues['em_phone'] != null &&
          formValues['em_owner'] != null &&
          formValues['em_location'] != null &&
          formValues['em_type'] != null) {
        var url = Uri.parse(Global.urlWeb + 'api/app/emergency/restful/');
        var request = http.MultipartRequest('POST', url)
          ..fields['em_app_id'] = Global.app_id
          ..fields['em_user_id'] = Global.user_id ?? ''
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

        if (feedback['data'] == "สำเร็จ") {
          // alertSuccess(context, '${feedback['data']}');
        } else {
          // alertWarning(context, '${feedback['data']}');
        }
      } else {
        // alertWarning(context, 'ใส่ข้อมูลให้ครบถ้วน');
      }
    } catch (e) {
      print(e);
    }
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
      var _data;
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
                padding: const EdgeInsets.all(40),
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
                        'em_type': '1',
                        // '2': '-',
                        'em_phone': user_phone,
                        'em_detail': '1',
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
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.white,
                            ),
                            child: FormBuilderDropdown(
                              name: 'em_type',
                              decoration: InputDecoration(
                                labelText: 'เลือกประเภทการแจ้งเหตุ',
                              ),
                              // initialValue: 'Male',
                              allowClear: true,
                              hint: Text('เลือกประเภทการแจ้งเหตุ'),
                              validator: RequiredValidator(
                                  errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
                              // initialValue: '1',
                              items: [
                                DropdownMenuItem(
                                    value: '1', child: Text('ผู้ป่วยฉุกเฉิน')),
                                DropdownMenuItem(
                                    value: '2', child: Text('ไฟฟ้ารั่ว')),
                                DropdownMenuItem(
                                    value: '3', child: Text('ไฟไหม้')),
                                DropdownMenuItem(
                                    value: '4', child: Text('เหตุระเบิด')),
                                DropdownMenuItem(
                                    value: '5', child: Text('อุบัติเหตุ')),
                                DropdownMenuItem(
                                    value: '6', child: Text('อาชญากรรม')),
                              ],
                            ),
                          ),

                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.white,
                            ),
                            child: FormBuilderTextField(
                              // initialValue: '1@gmail.com',
                              name: "em_owner",
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                helperText: 'ชื่อผู้แจ้ง',
                                // suffixIcon: Icon(
                                //   Icons.check_circle,
                                // ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ThemeBc.black),
                                ),
                                // hintText: 'ชื่อผู้แจ้ง',
                                filled: true,
                                fillColor: ThemeBc.white,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "ป้อนข้อมูลชื่อด้วย"),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 20),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.white,
                            ),
                            child: FormBuilderTextField(
                              // initialValue: '1@gmail.com',
                              name: "em_phone",
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                helperText: 'เบอร์โทรศัพท์',
                                suffixIcon: const Icon(
                                  Icons.check_circle,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: ThemeBc.black),
                                ),
                                // hintText: 'เบอร์โทรศัพท์',
                                filled: true,
                                fillColor: ThemeBc.white,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 20),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.white,
                            ),
                            child: FormBuilderTextField(
                              // initialValue: '1@gmail.com',
                              name: "em_detail",
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                helperText: 'รายละเอียดเหตุการณ์',
                                suffixIcon: const Icon(
                                  Icons.check_circle,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: ThemeBc.black),
                                ),
                                // hintText: 'อีเมล',
                                filled: true,
                                fillColor: ThemeBc.white,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "ป้อนข้อมูลอีเมลด้วย"),
                                // EmailValidator(errorText: "รูปแบบอีเมล์ไม่ถูกต้อง"),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 20),

                          FormBuilderImagePicker(
                            name: 'emi_path_name',
                            displayCustomType: (obj) =>
                                obj is ApiImage ? obj.imageUrl : obj,
                            decoration: const InputDecoration(
                                labelText: 'ภาพเหตุการณ์'),
                            maxImages: 5,
                            onSaved: (val) {
                              print(val);
                            },
                          ),

                          const SizedBox(height: 20),

                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 0),
                          //   margin: EdgeInsets.only(
                          //     top: 0,
                          //   ),
                          //   height: 300.0,
                          //   child: FutureBuilder(
                          //     future: getLocation(),
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot snapshot) {
                          //       if (snapshot.hasData) {
                          //         _handletap(LatLng point) {
                          //           em_location = point.toString();

                          //           setState(() {
                          //             myMarker = [];
                          //             myMarker.add(Marker(
                          //               markerId: MarkerId(point.toString()),
                          //               position: point,
                          //               infoWindow: InfoWindow(
                          //                 title: 'ตำแหน่งปัจจุบัน',
                          //               ),

                          //             ));
                          //           });
                          //           return position;
                          //         }

                          //         return Column(
                          //           children: [
                          //             Container(
                          //               height: 280,
                          //               child: GoogleMap(
                          //                 markers: Set.from(myMarker),
                          //                 onTap: _handletap,
                          //                 mapType: MapType.normal,
                          //                 onMapCreated: onMapCreated(),
                          //                 myLocationEnabled: true,
                          //                 initialCameraPosition: CameraPosition(
                          //                     target: LatLng(
                          //                         userLocation.latitude,
                          //                         userLocation.longitude),
                          //                     zoom: 15),
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //       } else {
                          //         return Center(
                          //           child: Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             children: <Widget>[
                          //               CircularProgressIndicator(),
                          //             ],
                          //           ),
                          //         );
                          //       }
                          //     },
                          //   ),
                          // ),

                          const SizedBox(height: 10),
                          //  mainMap(),
                          Text('จุดเกิดเหตุ',
                              style: TextStyle(
                                  fontSize: 12, color: ThemeBc.black)),
                          const SizedBox(height: 5),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: ThemeBc.white,
                            ),
                            child: Text(em_location),
                          ),
                          const SizedBox(height: 20),

                          // const Text('รูปภาพเหตุการณ์',
                          //     style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton.icon(
                            label: const Text('แจ้งเหตุฉุกเฉิน'),
                            icon: const Icon(Icons.add_alert_sharp),
                            style: ElevatedButton.styleFrom(
                              primary: ThemeBc.green,
                              //side: BorderSide(color: Colors.red, width: 5),
                              textStyle: const TextStyle(fontSize: 15),
                              padding: const EdgeInsets.all(15),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () {
                              if (_fbKey.currentState!.saveAndValidate()) {
                                // print(_fbKey.currentState.value);
                                addEmergecy(_fbKey.currentState!.value);
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    Widget emergecyPage2() {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: ListView(
          children: <Widget>[],
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
        title: const Text('แจ้งเหตุฉุกเฉิน',
            style: TextStyle(color: ThemeBc.white)),
        centerTitle: true,
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
      body: TabBarView(
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
    );
  }
}

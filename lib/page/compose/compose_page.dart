import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/custom_button.dart';
import 'package:cctv_tun/widgets/custom_buttonmenu.dart';
import 'package:cctv_tun/widgets/menus_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class compose_page extends StatefulWidget {
  compose_page({Key? key}) : super(key: key);

  @override
  _warn1State createState() => _warn1State();
}

class _warn1State extends State<compose_page> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<void> compose_page(Map formValues) async {
    //formValues['name']
    // print(formValues);
    try {
      var url =
          'https://www.bc-official.com/api/app_nt/api/app/emergency/restful/';
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Global.token}'
      },
          // body: json.encode({
          //   "firstname": formValues['firstname'],
          //   "lastname": formValues['lastname'],
          //   "email": formValues['email'],
          //   "password": formValues['password']
          // }));
          body: {
            "em_app_id": Global.app_id,
            "em_user_id": '1',
            "em_detail": formValues['em_detail'],
            "em_phone": formValues['em_phone'],
            "em_type": formValues['em_type'],
            "em_owner": formValues['em_owner'],
            "em_lat": '12.00',
            "em_lng": '13',
            "em_location": '12-13',
            "em_category": '1',
            // "emi_path_name[]": formValues['emi_path_name']
            // "user_app_id": Global.app_id,
            // "user_card_id": '1471200',
            // "user_firstname": formValues['firstname'],
            // "user_lastname": formValues['lastname'],
            // "user_email": formValues['email'],
            // "user_pass": formValues['password']
          });
      Map<String, dynamic> feedback = json.decode(response.body);

      if (response.statusCode == 201) {
        Alert(
          context: context,
          // title: "แจ้งเตือน",
          type: AlertType.success,
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login_page'),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();

        //กลับไปที่หน้า LoginPage
        // Future.delayed(const Duration(seconds: 5), () {
        //   // Navigator.pop(context);
        //    Navigator.pop(context, '/login');
        // });
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          // title: "แจ้งเตือน",
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();
      }
    } catch (e) {
      // print(e);
    }
  }

  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้องเรียน'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('ร้องเรียน')));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _fbKey,
              // initialValue: {'name': '', 'email': '', 'password': ''},
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonmenu(
                        title: 'แจ้งเรื่องร้องเรียน',
                        onPressed: () => Navigator.pushNamed(context, '/warn'),
                        colorButton: buttonGreyColor,
                        textStyle: secondaryTextStyle.copyWith(
                            fontWeight: medium, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      CustomButtonmenu(
                        title: 'เรื่องร้องเรียนของท่าน',
                        onPressed: () => Navigator.pushNamed(context, '/warn'),
                        colorButton: primaryColor,
                        textStyle: secondaryTextStyle.copyWith(
                            fontWeight: medium, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Material(
                    elevation: 18,
                    color: Colors.white,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: FormBuilderDropdown(
                      name: "em_type",

                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.article),
                        labelText: 'เลือกประเภทร้องเรียน',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // initialValue: 'Male',
                      //allowClear: true,
                      hint: Text('เลือกประเภทร้องเรียน'),

                      initialValue: '1',
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('ไฟฟ้าดับ'),
                        ),
                        DropdownMenuItem(
                            value: '2', child: Text('น้ำประปาไม่ไหล')),
                        DropdownMenuItem(
                            value: '3', child: Text('แจ้งซ่อมทางเดินเท้า')),
                        DropdownMenuItem(
                            value: '4', child: Text('แจ้งซ่อมถนน')),
                        DropdownMenuItem(
                            value: '5', child: Text('เรื่องร้องเรียนฝาท่อ')),
                        DropdownMenuItem(
                            value: '6', child: Text('ขยะไม่ได้รับกำจัด')),
                        DropdownMenuItem(
                            value: '7', child: Text('ได้รับการบริการ')),
                        DropdownMenuItem(
                            value: '8', child: Text('หน้าที่ที่ไม่เหมาะสม')),
                        DropdownMenuItem(value: '9', child: Text('อื่นๆ')),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: FormBuilderTextField(
                      name: "em_owner",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        labelText: 'ชื่อผู้แจ้ง',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Material(
                    elevation: 18,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: FormBuilderTextField(
                      name: "em_phone",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone_android),
                        labelText: 'เบอร์โทรศัพท์',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Material(
                    elevation: 18,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: FormBuilderTextField(
                      name: "em_detail",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.description),
                        labelText: 'รายละเอียดเหตุการณ์',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ), //รายละเอียดเหตุการณ์
                  ),
                  SizedBox(height: 18),
                  FormBuilderImagePicker(
                    name: 'emi_path_name',
                    iconColor: Colors.white70,
                    decoration: InputDecoration(
                      labelText: 'ภาพประกอบเหตุการ',
                      filled: true,
                    ),
                    maxImages: 1,
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    margin: EdgeInsets.only(
                      top: 0,
                    ),
                    height: 300.0,
                    child: FutureBuilder(
                      future: _getLocation(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(userLocation.latitude,
                                    userLocation.longitude),
                                zoom: 15),
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(userLocation.latitude, userLocation.longitude),
                          18));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} '),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.gps_fixed),
                    label: Text('ล็อกอินด้วย facebook'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[500],
                      onPrimary: Colors.white,
                      shadowColor: Colors.grey[700],
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    margin: EdgeInsets.only(top: 0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: 'แจ้งเหตุร้องเรียง',
                          onPressed: () {
                            if (_fbKey.currentState!.saveAndValidate()) {
                              //  print(_fbKey.currentState!.value);
                              compose_page(_fbKey.currentState!.value);
                            }
                          },
                          colorButton: buttonGreyColor,
                          textStyle: secondaryTextStyle.copyWith(
                              fontWeight: medium, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /* Widget imageSplash() {
      return Container();
      /* return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_box_outlined),
                  labelText: 'ชื่อผู้แจ้ง',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  labelText: 'เบอร์โทรสัพ',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.align_horizontal_left),
                  labelText: 'รายละเอียดเหตุการณ์',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      );*/
    }

    Widget textimport() {
      return FormBuilder(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Text(''),
                    ),
                  ],
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.account_box_outlined),
                      labelText: 'ชื่อผู้แจ้ง',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Text(''),
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      labelText: 'เบอร์โทรสัพ',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Text(''),
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.align_horizontal_left),
                      labelText: 'รายละเอียดเหตุการณ์',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget titleMenus() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: defaultMargin),
        child: Text(
          'เลือกประเภทการแจ้งเหตุ',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget balanceCard() {
      return FormBuilder(
        child: SafeArea(
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: defaultMargin),
                    MenusCustom(
                      iconMenus: 'assets/warn/01.png',
                      titleMenus: 'ผู้ป่วยฉุกเฉิน',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/02.png',
                      titleMenus: 'ไฟฟ้ารั่ว',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/03.png',
                      titleMenus: 'ไฟไหม้',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/04.png',
                      titleMenus: 'เหตุระเบิด',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/05.png',
                      titleMenus: 'อุบัติเหตุ',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/06.png',
                      titleMenus: 'อาชญากรรม',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        height: 80,
        margin: EdgeInsets.only(top: 20, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonmenu(
              title: 'แจ้งเหตุฉุกเฉิน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: buttonGreyColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
            SizedBox(width: 10),
            CustomButtonmenu(
              title: 'เหตุฉุกเฉินของท่าน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: primaryColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget buttonimagee() {
      return FormBuilder(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: defaultMargin),
                MenusCustom(
                  iconMenus: 'assets/warn/07.png',
                  titleMenus: '',
                  pathName: '/message',
                  titleMenus1: '',
                  titleMenus2: '',
                ),
                SizedBox(width: defaultMargin),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      );
    }

   /* Widget map() {
      Future<Position> _getLocation() async {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        userLocation = await Geolocator.getCurrentPosition();
        return userLocation;
      }

      LatLng latLng = LatLng(16.44544, 102.82839);
      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16.0,
      );
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: EdgeInsets.only(
          top: 0,
        ),
        height: 300.0,
        child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      );
    }

    Widget textphotoevent() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: defaultMargin),
        child: Text(
          'ภาพเหตุการณ์',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget textscene() {
      return FormBuilder(
        child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "เพิ่มเติม",
                      labelText: "จุดเกิดเหตุ",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  maxLength: 100,
                  maxLines: 2,
                ),
              ],
            )),
      );
    }

    Widget button1() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'แจ้งเหตุฉุกเฉิน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: buttonGreyColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ],
        ),
      );
    }*/*/
  }
}

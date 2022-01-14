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

class warn_page extends StatefulWidget {
  warn_page({Key? key}) : super(key: key);

  @override
  _warn1State createState() => _warn1State();
}

class _warn1State extends State<warn_page> {
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

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เแจ้งเหตุฉุกเฉิน'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('แจ้งเหตุฉุกเฉิน')));
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {'name': '', 'email': '', 'password': ''},
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonmenu(
                        title: 'แจ้งเหตุฉุกเฉิน',
                        onPressed: () => Navigator.pushNamed(context, '/warn'),
                        colorButton: buttonGreyColor,
                        textStyle: secondaryTextStyle.copyWith(
                            fontWeight: medium, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      CustomButtonmenu(
                        title: 'เหตุฉุกเฉินของท่าน',
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
                      name: "type",

                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.article),
                        labelText: 'เลือกประเภทการแจ้งเหตุ',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // initialValue: 'Male',
                      //allowClear: true,
                      hint: Text('เลือกประเภทการแจ้งเหตุ'),

                      initialValue: '1',
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('ผู้ป่วยฉุกเฉิน'),
                        ),
                        DropdownMenuItem(value: '2', child: Text('ไฟฟ้ารั่ว')),
                        DropdownMenuItem(value: '3', child: Text('ไฟไหม้')),
                        DropdownMenuItem(value: '4', child: Text('เหตุระเบิด')),
                        DropdownMenuItem(value: '5', child: Text('อุบัติเหตุ')),
                        DropdownMenuItem(value: '6', child: Text('อาชญากรรม')),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Material(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: FormBuilderTextField(
                      name: "name",
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
                      name: "name",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
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
                      name: "name",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        labelText: 'รายละเอียดเหตุการณ์',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ), //รายละเอียดเหตุการณ์
                  ),
                  SizedBox(height: 18),
                  FormBuilderImagePicker(
                    name: 'photos',
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
                      shape: const RoundedRectangleBorder(
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
                          title: 'แจ้งเหตุฉุกเฉิน',
                          onPressed: () =>
                              Navigator.pushNamed(context, '/warn'),
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
            padding: const EdgeInsets.all(8.0),
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

import 'dart:async';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class travelmap_page extends StatefulWidget {
  travelmap_page({Key? key}) : super(key: key);

  @override
  _travelmap_page createState() => _travelmap_page();
}

class _travelmap_page extends State<travelmap_page> {
  late Map<String, dynamic> imgSlide;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url =
        ('https://www.bc-official.com/api/app_nt/api/app/travel/restful/?travel_id=8&travel_app_id=${Global.app_id}');
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

  var travelmapname;
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

  late Position userLocation;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  LatLng latLng = LatLng(16.155182041998927, 103.30619597899741);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  var _currentLocation = 0;
  static final CameraPosition Sarakham = CameraPosition(
    target: LatLng(16.155182041998927, 103.30619597899741),
    zoom: 15,
  );

  Future<void> _go(CameraPosition cameraPosition) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    travelmapname = ModalRoute.of(context)!.settings.arguments;
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );
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
            SizedBox(height: 18),
            Center(child: Text('${travelmapname['travel_name']}')),
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
      // appBar: AppBar(
      //   title: Center(child: Text('${travelmapname['travel_name']}')),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Image.asset('assets/logo.png', scale: 15),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         ScaffoldMessenger.of(context)
      //             .showSnackBar(SnackBar(content: Text('แจ้งเหตุฉุกเฉิน')));
      //       },
      //     ),
      //   ],
      // ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              markers: <Marker>[
                Marker(
                    markerId: MarkerId('100'),
                    position: LatLng(16.155182041998927, 103.30619597899741),
                    infoWindow: InfoWindow(
                        title: 'ไปที่นี้กัน ${travelmapname['travel_name']}',
                        snippet: '--------------------------------------',
                        onTap: () {})),
              ].toSet(),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              initialCameraPosition: cameraPosition,
            );
          } else {
            return Center(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     CircularProgressIndicator(),
                  //    ],
                  ),
            );
          }
        },
      ),

      /* Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            margin: EdgeInsets.only(
              top: 0,
            ),
            height: 545.0,
            width: 550,
            child: GoogleMap(
              markers: <Marker>[
                Marker(
                    markerId: MarkerId('100'),
                    position: LatLng(16.155182041998927, 103.30619597899741),
                    infoWindow: InfoWindow(
                        title: 'ศูตย์ราชการมหาสารคาม',
                        snippet: '-------------------',
                        onTap: () {})),
              ].toSet(),
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          /*  GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(13.80564244, 100.5746134), zoom: 16),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controler) {
            _controller.complete(controler);
          },
        ),*/
        ],
      ),*/
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   items: [
      //     // BottomNavigationBarItem(
      //     //   title: Text('ตำแหน่งของคุณ '),
      //     //   icon: Icon(
      //     //     Icons.map,
      //     //   ),
      //     // ),
      //     BottomNavigationBarItem(
      //       title: Text('ศูนย์ราชการมหาสารคาม'),
      //       icon: Icon(
      //         Icons.tour_outlined,
      //       ),
      //     ),
      //   ],
      //   currentIndex: _currentLocation,
      //   onTap: (i) {
      //     setState(() {
      //       _currentLocation = i;
      //       print(i);
      //     });
      //     switch (i) {
      //       case 0:
      //         _go(Sarakham);
      //         break;
      //       case 1:
      //     }
      //   },
      // ),
    );
  }
}

import 'dart:async';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';

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
  // late GoogleMapController mapController;
  // Completer<GoogleMapController> _controller = Completer();
  // LatLng latLng = LatLng(16.155182041998927, 103.30619597899741);
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // var _currentLocation = 0;
  // static final CameraPosition Sarakham = CameraPosition(
  //   target: LatLng(16.155182041998927, 103.30619597899741),
  //   zoom: 15,
  // );

  // Future<void> _go(CameraPosition cameraPosition) async {
  //   final controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  @override
  Widget build(BuildContext context) {
    travelmapname = ModalRoute.of(context)!.settings.arguments;
    late var app_lat =
        double.parse(travelmapname['travel_lat'] ?? "16.04594422566426");
    late var app_lng =
        double.parse(travelmapname['travel_lng'] ?? "103.11927574700533");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Center(
          child: Text('${travelmapname['travel_name']}'),
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
        color: ThemeBc.white,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: secondaryTextColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 4),
                            blurRadius: 7.0,
                            spreadRadius: 1.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 400,
                      child: Column(
                        children: [
                          Flexible(
                              child: FlutterMap(
                            options: MapOptions(
                                center: LatLng(app_lat, app_lng), zoom: 16),
                            layers: [
                              TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                                attributionBuilder: (_) {
                                  return Text('');
                                },
                              ),
                              MarkerLayerOptions(markers: [
                                Marker(
                                  point: LatLng(app_lat, app_lng),
                                  builder: (ctx) => IconButton(
                                    icon: Icon(
                                      Icons.where_to_vote,
                                    ),
                                    tooltip: 'Show Snackbar',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                '${travelmapname['travel_name']}'),
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
              SizedBox(height: 5),
              Container(
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: ThemeBc.black,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2, 4),
                                  blurRadius: 7.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              Center(
                                child: Text(
                                    'เที่ยว : ${travelmapname['travel_name']}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      // backgroundColor: Colors.black45,
                                      color: ThemeBc.white,
                                    )),
                              ),
                              Text(
                                  'เนื้อหา : ${travelmapname['travel_detail']} ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: Colors.black45,
                                    color: ThemeBc.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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

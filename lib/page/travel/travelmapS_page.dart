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

class travelmapS_page extends StatefulWidget {
  travelmapS_page({Key? key}) : super(key: key);

  @override
  _travelmap_page createState() => _travelmap_page();
}

class _travelmap_page extends State<travelmapS_page> {
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
    // CameraPosition cameraPosition = CameraPosition(
    //   target: latLng,
    //   zoom: 14,
    // );
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          color: ThemeBc.white,
          child: Container(
            decoration: BoxDecoration(
                color: ThemeBc.background,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  icon: Icon(
                    Icons.kitesurfing,
                    size: 30,
                    color: ThemeBc.white,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('กำลังพัฒนา')));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.landscape,
                    size: 30,
                    color: ThemeBc.white,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('กำลังพัฒนา')));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(
          child: Text('ที่ท้องเที่ยวในมหาสารคาม'),
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
      body: Container(
        color: ThemeBc.background,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ListView(
            children: [
              Container(
                child: Container(
                  height: 700,
                  child: Column(
                    children: [
                      Flexible(
                          child: FlutterMap(
                        options: MapOptions(
                            center:
                                LatLng(16.186348810730625, 103.30025897021274),
                            zoom: 13),
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
                              point:
                                  LatLng(16.1863488107307, 103.3002589702128),
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
                                        content: Text('มหาสารคาม'),
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

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FutureBuilder(
                //     future: _getLocation(),
                //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                //       if (snapshot.hasData) {
                //         return GoogleMap(
                //           markers: <Marker>[
                //             Marker(
                //                 markerId: MarkerId('100'),
                //                 position:
                //                     LatLng(16.155182041998927, 103.30619597899741),
                //                 infoWindow: InfoWindow(
                //                     title:
                //                         'ไปที่นี้กัน ${travelmapname['travel_name']}',
                //                     snippet:
                //                         '--------------------------------------',
                //                     onTap: () {})),
                //           ].toSet(),
                //           mapType: MapType.normal,
                //           onMapCreated: (GoogleMapController controller) {
                //             _controller.complete(controller);
                //           },
                //           myLocationEnabled: true,
                //           initialCameraPosition: cameraPosition,
                //         );
                //       } else {
                //         return Center(
                //           child: Column(
                //               // mainAxisAlignment: MainAxisAlignment.center,
                //               //   children: <Widget>[
                //               //     CircularProgressIndicator(),
                //               //    ],
                //               ),
                //         );
                //       }
                //     },
                //   ),
                // ),
              ),
              SizedBox(height: 20),
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

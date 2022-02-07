import 'dart:async';

import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_page extends StatefulWidget {
  map_page({Key? key}) : super(key: key);

  @override
  _map_prod createState() => _map_prod();
}

class _map_prod extends State<map_page> {
  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation != null;
    }
    return userLocation;
  }

  var hotlinee;

  late Position userLocation;

  // late GoogleMapController mapController;
  // Completer<GoogleMapController> _controller = Completer();
  // LatLng latLng = const LatLng(14, 103.30025897021274);
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // // var _currentLocation = 0;
  // // static final CameraPosition Sarakham = CameraPosition(
  // //   target: LatLng(16.186348810730625, 103.30025897021274),
  // //   zoom: 15,
  // // );
  // // static final CameraPosition Sarakham1 = const CameraPosition(
  // //   target: LatLng(16.155182041998927, 103.30619597899741),
  // //   zoom: 16,
  // // );

  // Future<void> _go(CameraPosition cameraPosition) async {
  //   final controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  @override
  Widget build(BuildContext context) {
    hotlinee = ModalRoute.of(context)!.settings.arguments;
    late var app_lat =
        double.parse(hotlinee['hotlineLat'] ?? "16.04594422566426");
    late var app_lng =
        double.parse(hotlinee['hotlineLng'] ?? "103.11927574700533");

    // hotlinee = ModalRoute.of(context)!.settings.arguments;
    // var app_lat = double.parse(hotlinee['travelLat'] ?? "102.83473877038512");
    // var app_lng = double.parse(hotlinee['travelLng'] ?? "102.83473877038512");

    // CameraPosition cameraPosition = CameraPosition(
    //   target: LatLng(102.83473877038512, 102.83473877038512),
    //   zoom: 14,
    // );
    return Scaffold(
      backgroundColor: ThemeBc.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Column(
          children: [
            Container(
              height: 50,
              width: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Center(child: Text('pro')),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: const Text('แจ้งเหตุฉุกเฉิน')));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: _getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 1000,
                child: ListView(
                  children: [
                    Container(
                      color: ThemeBc.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                              height: 600,
                              child: Column(
                                children: [
                                  Flexible(
                                      child: FlutterMap(
                                    options: MapOptions(
                                        center: LatLng(app_lat, app_lng),
                                        zoom: 16),
                                    layers: [
                                      TileLayerOptions(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c'],
                                        attributionBuilder: (_) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                // ElevatedButton.icon(
                                                //   onPressed: () {
                                                //     print('$userLocation');
                                                //     // locn = userLocation.latitude;
                                                //     // locn2 = userLocation
                                                //     //     .longitude; // mapController.animateCamera(CameraUpdate.newLatLngZoom(
                                                //     // //     LatLng(userLocation.latitude, userLocation.longitude),
                                                //     // //     18));
                                                //     showDialog(
                                                //       context: context,
                                                //       builder: (context) {
                                                //         return AlertDialog(
                                                //           content: Text(
                                                //               'ตำแหน่ง !\nละติจูด :// ${locn} ลองจิจูด : ${locn} ตำแหน่งที่คุณเลือก : '),
                                                //         );
                                                //       },
                                                //     );
                                                //   },
                                                //   icon: Icon(Icons.gps_fixed),
                                                //   label: Text('ตำแหน่งของคุณ'),
                                                //   style: ElevatedButton.styleFrom(
                                                //     primary: ThemeBc.background,
                                                //     onPrimary: Colors.white,
                                                //     elevation: 30,
                                                //     shape: RoundedRectangleBorder(
                                                //         borderRadius: BorderRadius.all(
                                                //             Radius.circular(40))),
                                                //   ),
                                                // ),

                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: secondaryTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Text(
                                                      "เทศบาลมหาสารคาม",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      MarkerLayerOptions(markers: [
                                        Marker(
                                          point: LatLng(app_lat, app_lng),
                                          builder: (ctx) => IconButton(
                                            icon: Icon(Icons.pin_drop),
                                            tooltip: 'Show Snackbar',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'ตำแหน่งศูนย์ : ${hotlinee['hotlineName']}'),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Marker(
                                          point: LatLng(userLocation.latitude,
                                              userLocation.longitude),
                                          builder: (ctx) => const Icon(
                                              Icons.my_location_outlined),
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
      //   height: 1000,
      //   child: FutureBuilder(
      //     future: _getLocation(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData) {
      //         return Container(
      //           height: 500,
      //           child: ListView(
      //             children: [
      //               Container(
      //                 height: 1000,
      //                 child: GoogleMap(
      //                   markers: <Marker>[
      //                     Marker(
      //                         markerId: const MarkerId('100'),
      //                         position: LatLng(
      //                             102.83473877038512, 102.83473877038512),
      //                         infoWindow: InfoWindow(
      //                             title: 'ตำแหน่งของศูนย์',
      //                             //   snippet: '-------------------',
      //                             onTap: () {})),
      //                   ].toSet(),
      //                   mapType: MapType.normal,
      //                   onMapCreated: (GoogleMapController controller) {
      //                     _controller.complete(controller);
      //                   },
      //                   myLocationEnabled: true,
      //                   initialCameraPosition: cameraPosition,
      //                 ),
      //               ),
      //             ],
      //           ),
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
      //     const BottomNavigationBarItem(
      //       title: const Text('มหาสารคาม '),
      //       icon: const Icon(
      //         Icons.map,
      //       ),
      //     ),
      //     const BottomNavigationBarItem(
      //       title: Text('ศูนย์ราชการมหาสารคาม'),
      //       icon: Icon(
      //         Icons.tour_outlined,
      //       ),
      //     ),
      //   ],
      // currentIndex: _currentLocation,
      // onTap: (i) {
      //   setState(() {
      //     _currentLocation = i;
      //     print(i);
      //   });
      //   switch (i) {
      //     case 0:
      //       _go(Sarakham);
      //       break;
      //     case 1:
      //       _go(Sarakham1);
      //   }
      // },
      // ),
    );
  }
}

// import 'dart:async';

// import 'package:cctv_tun/page/global/style/global.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';

// class map_page extends StatefulWidget {
//   map_page({Key? key}) : super(key: key);

//   @override
//   _map_pageState createState() => _map_pageState();
// }

// late var locn = '';
// late var locn2 = '';

// class _map_pageState extends State<map_page> {
//   Future<Position> _getLocation() async {
//     late Position userLocation;
//     try {
//       userLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//     } catch (e) {
//       userLocation != null;
//     }
//     return userLocation;
//   }

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

//   var hotlinee;

//   late Position userLocation;
//   // late GoogleMapController mapController;
//   // Completer<GoogleMapController> _controller = Completer();
//   // LatLng latLng = const LatLng(14, 103.30025897021274);
//   // void _onMapCreated(GoogleMapController controller) {
//   //   mapController = controller;
//   // }

//   // var _currentLocation = 0;
//   // static final CameraPosition Sarakham = CameraPosition(
//   //   target: LatLng(16.186348810730625, 103.30025897021274),
//   //   zoom: 15,
//   // );
//   // static final CameraPosition Sarakham1 = const CameraPosition(
//   //   target: LatLng(16.155182041998927, 103.30619597899741),
//   //   zoom: 16,
//   // );

//   // Future<void> _go(CameraPosition cameraPosition) async {
//   //   final controller = await _controller.future;
//   //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   // }

//   @override
//   Widget build(BuildContext context) {
    // hotlinee = ModalRoute.of(context)!.settings.arguments;
    // var app_lat = double.parse(hotlinee['hotlineLat'] ?? "16.04594422566426");
    // var app_lng = double.parse(hotlinee['hotlineLng'] ?? "103.11927574700533");

//     // // CameraPosition cameraPosition = CameraPosition(
//     //   target: LatLng(app_lat, app_lng),
//     //   zoom: 14,
//     // );
//     return Scaffold(
//       backgroundColor: ThemeBc.black,
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: ThemeBc.background, //change your color here
//         ),
//         shadowColor: ThemeBc.white,
//         foregroundColor: ThemeBc.white,
//         backgroundColor: ThemeBc.background,
//         // title: Center(child: Text('${hotlinee['hotlineName']}')),
//         actions: <Widget>[
//           IconButton(
//             icon: Image.asset('assets/logo.png', scale: 15),
//             tooltip: 'Show Snackbar',
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: const Text('แจ้งเหตุฉุกเฉิน')));
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//           future: _getLocation(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Text('${userLocation.latitude} ${userLocation.longitude}');
//             } else {
//               return Center(
//                 child: Column(
//                   children: <Widget>[
//                     CircularProgressIndicator(),
//                   ],
//                 ),
//               );
//             }
//             return Container();
//           }),
      // body: ListView(
      //   children: [

      //     Container(
      //       color: ThemeBc.background,
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Container(
      //           decoration: BoxDecoration(
      //               color: secondaryTextColor,
      //               borderRadius: BorderRadius.circular(
      //                 20,
      //               ),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.grey.withOpacity(0.5),
      //                     offset: Offset(2, 2),
      //                     blurRadius: 7,
      //                     spreadRadius: 1.0),
      //                 BoxShadow(
      //                     color: Colors.black.withOpacity(0.5),
      //                     offset: Offset(2, 4),
      //                     blurRadius: 7.0,
      //                     spreadRadius: 1.0),
      //               ]),
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Container(
      //               height: 700,
      //               child: Column(
      //                 children: [
      //                   Flexible(
      //                       child: FlutterMap(
      //                     options: MapOptions(
      //                         center: LatLng(app_lat, app_lng), zoom: 16),
      //                     layers: [
      //                       TileLayerOptions(
      //                         urlTemplate:
      //                             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      //                         subdomains: ['a', 'b', 'c'],
      //                         attributionBuilder: (_) {
      //                           return Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Row(
      //                               children: [
      //                                 // ElevatedButton.icon(
      //                                 //   onPressed: () {
      //                                 //     print('$userLocation');
      //                                 //     // locn = userLocation.latitude;
      //                                 //     // locn2 = userLocation
      //                                 //     //     .longitude; // mapController.animateCamera(CameraUpdate.newLatLngZoom(
      //                                 //     // //     LatLng(userLocation.latitude, userLocation.longitude),
      //                                 //     // //     18));
      //                                 //     showDialog(
      //                                 //       context: context,
      //                                 //       builder: (context) {
      //                                 //         return AlertDialog(
      //                                 //           content: Text(
      //                                 //               'ตำแหน่ง !\nละติจูด :// ${locn} ลองจิจูด : ${locn} ตำแหน่งที่คุณเลือก : '),
      //                                 //         );
      //                                 //       },
      //                                 //     );
      //                                 //   },
      //                                 //   icon: Icon(Icons.gps_fixed),
      //                                 //   label: Text('ตำแหน่งของคุณ'),
      //                                 //   style: ElevatedButton.styleFrom(
      //                                 //     primary: ThemeBc.background,
      //                                 //     onPrimary: Colors.white,
      //                                 //     elevation: 30,
      //                                 //     shape: RoundedRectangleBorder(
      //                                 //         borderRadius: BorderRadius.all(
      //                                 //             Radius.circular(40))),
      //                                 //   ),
      //                                 // ),
      //                                 Text(
      //                                   "เทศบาลมหาสารคาม",
      //                                   style: TextStyle(
      //                                     fontSize: 20.0,
      //                                     fontWeight: FontWeight.bold,
      //                                     // backgroundColor: Colors.black45,
      //                                     color: Colors.black,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                       MarkerLayerOptions(markers: [
      //                         Marker(
      //                           point: LatLng(app_lat, app_lng),
      //                           builder: (ctx) => const Icon(Icons.pin_drop),
      //                         )
      //                       ]),
      //                     ],
      //                   ))
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
//     );
//   }
// }

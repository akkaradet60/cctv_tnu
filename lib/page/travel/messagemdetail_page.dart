// import 'dart:async';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/shared/theme.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class travelmap_page extends StatefulWidget {
//   travelmap_page({Key? key}) : super(key: key);

//   @override
//   _productsState createState() => _productsState();
// }

// class _productsState extends State<travelmap_page> {
//   var productt;
//   var detail;
//   bool isLoading = true;
//   late Map<String, dynamic> imgSlide;

//   int _currentIndex = 0;
//   Future<Map<String, dynamic>> getDataSlide() async {
//     var url =
//         ('https://www.bc-official.com/api/app_nt/api/app/travel/restful/?travel_id=8&travel_app_id=${Global.app_id}');
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
// Future<Position> _getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     userLocation = await Geolocator.getCurrentPosition();
//     return userLocation;
//   }

//   late Position userLocation;
//   late GoogleMapController mapController;
//   Completer<GoogleMapController> _controller = Completer();
//   LatLng latLng = LatLng(16.155182041998927, 103.30619597899741);
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   var _currentLocation = 0;
//   static final CameraPosition Sarakham = CameraPosition(
//     target: LatLng(16.155182041998927, 103.30619597899741),
//     zoom: 15,
//   );

//   Future<void> _go(CameraPosition cameraPosition) async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }
//   // var _counter = 1;
//   // var _product = int.parse('0');
//   // var _product1 = int.parse('0');

//   /* void _incrementCounter() {
//     setState(() {
//       _counter++;
//       _product = _product + _product1;
//     });
//   }*/

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//       CameraPosition cameraPosition = CameraPosition(
//       target: latLng,
//       zoom: 14,
//     );
//     // void _incrementCounter() {
//     //   _product1 = int.parse('${productt['productPrice']}');
//     //   setState(() {
//     //     _counter++;
//     //     _product = _product + _product1;
//     //   });
//     // }

//     // void _incrementCounterp() {
//     //   setState(() {
//     //     _product1 = int.parse('${productt['productPrice']}');
//     //     _counter--;
//     //     _product = _product - _product1;
//     //     if (_counter < 0) {
//     //       _counter = 0;
//     //     }
//     //     if (_product < 0) {
//     //       _product = 0;
//     //     }
//     //   });
//     // }

//     productt = ModalRoute.of(context)!.settings.arguments;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('${productt['travel_name']}'),
//           actions: <Widget>[
//             IconButton(
//               icon: Image.asset('assets/logo.png', scale: 15),
//               tooltip: 'Show Snackbar',
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.pinkAccent, Colors.orangeAccent],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft)),
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Card(
//               child: Container(
//                 height: 1000,
//                 child: ListView(
//                   children: [
//                      Container(
//         height: 800,
//         child: ListView(
//           children: [
//             Text('data'),
//             Container(
//               height: 800,
//               child: FutureBuilder(
//                 future: _getLocation(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     return GoogleMap(
//                       markers: <Marker>[
//                         Marker(
//                             markerId: MarkerId('100'),
//                             position:
//                                 LatLng(16.155182041998927, 103.30619597899741),
//                             infoWindow: InfoWindow(
//                                 title: '',
//                                 snippet: '-------------------',
//                                 onTap: () {})),
//                       ].toSet(),
//                       mapType: MapType.normal,
//                       onMapCreated: (GoogleMapController controller) {
//                         _controller.complete(controller);
//                       },
//                       myLocationEnabled: true,
//                       initialCameraPosition: cameraPosition,
//                     );
//                   } else {
//                     return Center(
//                       child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           //   children: <Widget>[
//                           //     CircularProgressIndicator(),
//                           //    ],
//                           ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
                     
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }

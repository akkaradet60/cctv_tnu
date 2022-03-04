import 'dart:async';

import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class map_prod extends StatefulWidget {
  map_prod({Key? key}) : super(key: key);

  @override
  _map_prod createState() => _map_prod();
}

class _map_prod extends State<map_prod> {
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
    // hotlinee = ModalRoute.of(context)!.settings.arguments;
    // var app_lat = double.parse(hotlinee['travelLat'] ?? "102.83473877038512");
    // var app_lng = double.parse(hotlinee['travelLng'] ?? "102.83473877038512");

    // CameraPosition cameraPosition = CameraPosition(
    //   target: LatLng(102.83473877038512, 102.83473877038512),
    //   zoom: 14,
    // );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Column(
          children: [
            Center(child: Text('pro')),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: ThemeBc.background,
            ),
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
              return Text('${userLocation.latitude} ${userLocation.longitude}');
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

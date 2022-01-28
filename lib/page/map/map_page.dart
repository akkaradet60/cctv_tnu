import 'dart:async';

import 'package:cctv_tun/models/hotlinee/hotlinee.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_page extends StatefulWidget {
  map_page({Key? key}) : super(key: key);

  @override
  _map_pageState createState() => _map_pageState();
}

class _map_pageState extends State<map_page> {
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

  var hotlinee;

  late Position userLocation;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  LatLng latLng = const LatLng(14, 103.30025897021274);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // var _currentLocation = 0;
  // static final CameraPosition Sarakham = CameraPosition(
  //   target: LatLng(16.186348810730625, 103.30025897021274),
  //   zoom: 15,
  // );
  // static final CameraPosition Sarakham1 = const CameraPosition(
  //   target: LatLng(16.155182041998927, 103.30619597899741),
  //   zoom: 16,
  // );

  Future<void> _go(CameraPosition cameraPosition) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    hotlinee = ModalRoute.of(context)!.settings.arguments;
    var app_lat = double.parse(hotlinee['hotlineLat'] ?? "102.83473877038512");
    var app_lng = double.parse(hotlinee['hotlineLng'] ?? "102.83473877038512");

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(app_lat, app_lng),
      zoom: 14,
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Center(child: Text('${hotlinee['hotlineName']}')),
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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              markers: <Marker>[
                Marker(
                    markerId: const MarkerId('100'),
                    position: LatLng(app_lat, app_lng),
                    infoWindow: InfoWindow(
                        title: 'ตำแหน่งของศูนย์ ${hotlinee['hotlineName']}',
                        //   snippet: '-------------------',
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

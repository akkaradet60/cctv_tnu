import 'dart:async';

import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_page2 extends StatefulWidget {
  map_page2({Key? key}) : super(key: key);

  @override
  _map_pageState createState() => _map_pageState();
}

class _map_pageState extends State<map_page2> {
  double? lat1, lne2;
  Completer<GoogleMapController> _controller = Completer();
  LatLng latLng = LatLng(16.186348810730625, 103.30025897021274);

  var _currentLocation = 0;
  static final CameraPosition Sarakham = CameraPosition(
    target: LatLng(16.186348810730625, 103.30025897021274),
    zoom: 15,
  );
  static final CameraPosition Sarakham1 = CameraPosition(
    target: LatLng(16.155182041998927, 103.30619597899741),
    zoom: 16,
  );

  Future<void> _go(CameraPosition cameraPosition) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            title: Text('มหาสารคาม '),
            icon: Icon(
              Icons.map,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('ศูนย์ราชการมหาสารคาม'),
            icon: Icon(
              Icons.tour_outlined,
            ),
          ),
        ],
        currentIndex: _currentLocation,
        onTap: (i) {
          setState(() {
            _currentLocation = i;
            print(i);
          });
          switch (i) {
            case 0:
              _go(Sarakham);
              break;
            case 1:
              _go(Sarakham1);
          }
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_page extends StatefulWidget {
  map_page({Key? key}) : super(key: key);

  @override
  _map_pageState createState() => _map_pageState();
}

class _map_pageState extends State<map_page> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(16.44544, 102.82839);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
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
              height: 600.0,
              width: 550,
              child: GoogleMap(
                markers: <Marker>[
                  Marker(
                      markerId: MarkerId('100'),
                      position: LatLng(16.44544, 102.82839),
                      infoWindow: InfoWindow(
                          title: 'ห้องเรา 405 นะ',
                          snippet: 'ผมเอง',
                          onTap: () {}))
                ].toSet(),
                initialCameraPosition: cameraPosition,
                mapType: MapType.normal,
                onMapCreated: (controller) {},
              ),
            )

            /*  GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(13.80564244, 100.5746134), zoom: 16),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controler) {
            _controller.complete(controler);
          },
        ),*/
          ],
        ));
  }
}

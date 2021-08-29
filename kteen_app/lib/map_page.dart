import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kteen_app/models/YouthWelfareCenter.dart';
import 'package:kteen_app/map_article_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        '청소년 센터 지도',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {

          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Marker> _markers = [];
  Completer<GoogleMapController> _controller = Completer();
  YouthWelfareCenterDTO _youthWelfareCenterDTO = YouthWelfareCenterDTO();

  static final CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(37.28361081597115, 127.04646759138873),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _markers.add(Marker(
      markerId: MarkerId('location_my'),
      draggable: true,
      onTap: () {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: LatLng(37.28361081597115, 127.04646759138873),
    ));
    
    _youthWelfareCenterDTO.readJson().then((value) {
      for (int i = 0; i < value.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId('location_$i'),
          draggable: true,
          onTap: () {},
          position: LatLng(
            double.parse(value[i].REFINEWGS84LAT),
            double.parse(value[i].REFINEWGS84LOGT),
          ),
          infoWindow: InfoWindow(
            title: '${value[i].CONSLTNCENTEROPERTGRPNM}',
            snippet: '${value[i].REFINEROADNMADDR}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapArticlePage(data: value[i]),),
              );
            },
          ),
        ));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: Set.from(_markers),
      initialCameraPosition: _defaultCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
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
  List<Marker> _markers = [];
  Completer<GoogleMapController> _controller = Completer();

  Future<List<YouthWelfareCenter>> _youthWelfareCenterFuture;
  List<YouthWelfareCenter> _youthWelfareCenterList = [];
  List<String> _youthWelfareCenterTitleList = [];

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

    _youthWelfareCenterFuture = readYouthWelfareCounselingCenter().then((value) {
      value.forEach((element) {
        _youthWelfareCenterList.add(element);
        _youthWelfareCenterTitleList.add(element.CONSLTNCENTEROPERTGRPNM);

        _markers.add(Marker(
          markerId: MarkerId('${element.CONSLTNCENTEROPERTGRPNM}'),
          draggable: true,
          onTap: () {},
          position: LatLng(
            double.parse(element.REFINEWGS84LAT),
            double.parse(element.REFINEWGS84LOGT),
          ),
          infoWindow: InfoWindow(
            title: '${element.CONSLTNCENTEROPERTGRPNM}',
            snippet: '${element.REFINEROADNMADDR}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapArticlePage(data: element),),
              );
            },
          ),
        ));
      });

      setState(() {});

      return value;
    });
  }

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
            showSearch(context: context, delegate:Search(_youthWelfareCenterList, _youthWelfareCenterTitleList));
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
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

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;
  int selectedResultIndex;

  @override
  Widget buildResults(BuildContext context) {
    return MapArticlePage(data: dataList[selectedResultIndex]);
  }

  final List<YouthWelfareCenter> dataList;
  final List<String> searchList;

  Search(this.dataList, this.searchList);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty ? suggestionList = recentList : suggestionList.addAll(
        searchList.where((element) => element.contains(query),)
    );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            selectedResultIndex = searchList.indexOf(selectedResult);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapArticlePage(data: dataList[selectedResultIndex]),),
            );
          },
        );
      },
    );
  }
}
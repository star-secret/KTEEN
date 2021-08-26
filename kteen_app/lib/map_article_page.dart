import 'package:flutter/material.dart';
import 'package:kteen_app/models/YouthWelfareCenter.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MapArticlePage extends StatelessWidget {
  const MapArticlePage({
    Key key,
    @required YouthWelfareCenter data,
  }): _data = data, super(key: key);

  final YouthWelfareCenter _data;

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
        '청소년 센터 정보',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Title(
                      color: Colors.black,
                      child: Text(
                        '${_data.CONSLTNCENTEROPERTGRPNM}',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(16.0)),
                    Text(
                      '${_data.REFINEROADNMADDR}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Padding(padding: const EdgeInsets.all(16.0)),
                    SelectableLinkify(
                      onOpen: _onOpen,
                      textScaleFactor: 1.2,
                      text: '${_data.HMPGADDR}',
                    ),
                    Padding(padding: const EdgeInsets.all(16.0)),
                    Text(
                      '${_data.CENTERTELNO}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}

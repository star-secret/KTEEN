import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<YouthWelfareService>> _youthWelfareService;

  // Fetch content from the json file
  Future<List<YouthWelfareService>> readJson() async {
    final String response = await rootBundle.loadString('assets/YouthWelfareServiceList.json');

    List list = await json.decode(response);
    var youthWelfareService = list.map((element) => YouthWelfareService.fromJson(element)).toList();

    return youthWelfareService;
  }

  @override
  void initState() {
    _youthWelfareService = readJson();
    super.initState();
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
        'List Page',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              FutureBuilder<List<YouthWelfareService>>(
                future: _youthWelfareService,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data[index].TITLE),
                          ),
                        );
                      }
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YouthWelfareService {
  String TITLE;
  String MAINPURPS;
  String RELATEINFO;
  String GUIDCONT;
  String OPERTMAINBDNM;
  String OPERTORGNZTNM;
  String OPERTBEGINDE;

  YouthWelfareService({
    this.TITLE,
    this.MAINPURPS,
    this.RELATEINFO,
    this.GUIDCONT,
    this.OPERTMAINBDNM,
    this.OPERTORGNZTNM,
    this.OPERTBEGINDE
  });

  YouthWelfareService.fromJson(Map<String, dynamic> json) {
    TITLE = json['TITLE'];
    MAINPURPS = json['MAIN_PURPS'];
    RELATEINFO = json['RELATE_INFO'];
    GUIDCONT = json['GUID_CONT'];
    OPERTMAINBDNM = json['OPERT_MAINBD_NM'];
    OPERTORGNZTNM = json['OPERT_ORGNZT_NM'];
    OPERTBEGINDE = json['OPERT_BEGIN_DE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TITLE'] = this.TITLE;
    data['MAIN_PURPS'] = this.MAINPURPS;
    data['RELATE_INFO'] = this.RELATEINFO;
    data['GUID_CONT'] = this.GUIDCONT;
    data['OPERT_MAINBD_NM'] = this.OPERTMAINBDNM;
    data['OPERT_ORGNZT_NM'] = this.OPERTORGNZTNM;
    data['OPERT_BEGIN_DE'] = this.OPERTBEGINDE;
    return data;
  }
}
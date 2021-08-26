import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<YouthWelfareService>> readYouthWelfareService() async {
  final String response = await rootBundle.loadString('assets/YouthWelfareServiceList.json');

  List list = await json.decode(response);
  var youthWelfareServiceList = list.map((element) => YouthWelfareService.fromJson(element)).toList();

  return youthWelfareServiceList;
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
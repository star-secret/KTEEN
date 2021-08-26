import 'dart:convert';

import 'package:flutter/services.dart';

class YouthWelfareCenterDTO {
  List<YouthWelfareCenter> youthWelfareCounselingCenterList;

  Future<List<YouthWelfareCenter>> readJson() async {
    final String response = await rootBundle.loadString('assets/YouthWelfareCenterList.json');

    List list = await json.decode(response);
    youthWelfareCounselingCenterList = list.map((element) => YouthWelfareCenter.fromJson(element)).toList();

    return youthWelfareCounselingCenterList;
  }
}

class YouthWelfareCenter {
  String CONSLTNCENTEROPERTGRPNM;
  String CENTERTELNO;
  String HMPGADDR;
  String REFINEZIPNO;
  String REFINELOTNOADDR;
  String REFINEROADNMADDR;
  String REFINEWGS84LAT;
  String REFINEWGS84LOGT;

  YouthWelfareCenter({
    this.CONSLTNCENTEROPERTGRPNM,
    this.CENTERTELNO,
    this.HMPGADDR,
    this.REFINEZIPNO,
    this.REFINELOTNOADDR,
    this.REFINEROADNMADDR,
    this.REFINEWGS84LAT,
    this.REFINEWGS84LOGT
  });

  YouthWelfareCenter.fromJson(Map<String, dynamic> json) {
    CONSLTNCENTEROPERTGRPNM = json['CONSLTN_CENTER_OPERT_GRP_NM'];
    CENTERTELNO = json['CENTER_TELNO'];
    HMPGADDR = json['HMPG_ADDR'];
    REFINEZIPNO = json['REFINE_ZIPNO'];
    REFINELOTNOADDR = json['REFINE_LOTNO_ADDR'];
    REFINEROADNMADDR = json['REFINE_ROADNM_ADDR'];
    REFINEWGS84LAT = json['REFINE_WGS84_LAT'];
    REFINEWGS84LOGT = json['REFINE_WGS84_LOGT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CONSLTN_CENTER_OPERT_GRP_NM'] = this.CONSLTNCENTEROPERTGRPNM;
    data['CENTER_TELNO'] = this.CENTERTELNO;
    data['HMPG_ADDR'] = this.HMPGADDR;
    data['REFINE_ZIPNO'] = this.REFINEZIPNO;
    data['REFINE_LOTNO_ADDR'] = this.REFINELOTNOADDR;
    data['REFINE_ROADNM_ADDR'] = this.REFINEROADNMADDR;
    data['REFINE_WGS84_LAT'] = this.REFINEWGS84LAT;
    data['REFINE_WGS84_LOGT'] = this.REFINEWGS84LOGT;
    return data;
  }
}
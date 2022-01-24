class Hotlinee {
  List<Data>? data;
  bool? error;

  Hotlinee({this.data, this.error});

  Hotlinee.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? hotlineId;
  String? hotlineUserId;
  String? hotlineCat;
  String? hotlineName;
  String? hotlineDetail;
  String? hotlinePhone;
  String? hotlineLat;
  String? hotlineLng;
  String? hotlineUpdateDate;
  String? hotlineCreateDate;

  Data(
      {this.hotlineId,
      this.hotlineUserId,
      this.hotlineCat,
      this.hotlineName,
      this.hotlineDetail,
      this.hotlinePhone,
      this.hotlineLat,
      this.hotlineLng,
      this.hotlineUpdateDate,
      this.hotlineCreateDate});

  Data.fromJson(Map<String, dynamic> json) {
    hotlineId = json['hotline_id'];
    hotlineUserId = json['hotline_user_id'];
    hotlineCat = json['hotline_cat'];
    hotlineName = json['hotline_name'];
    hotlineDetail = json['hotline_detail'];
    hotlinePhone = json['hotline_phone'];
    hotlineLat = json['hotline_lat'];
    hotlineLng = json['hotline_lng'];
    hotlineUpdateDate = json['hotline_update_date'];
    hotlineCreateDate = json['hotline_create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotline_id'] = this.hotlineId;
    data['hotline_user_id'] = this.hotlineUserId;
    data['hotline_cat'] = this.hotlineCat;
    data['hotline_name'] = this.hotlineName;
    data['hotline_detail'] = this.hotlineDetail;
    data['hotline_phone'] = this.hotlinePhone;
    data['hotline_lat'] = this.hotlineLat;
    data['hotline_lng'] = this.hotlineLng;
    data['hotline_update_date'] = this.hotlineUpdateDate;
    data['hotline_create_date'] = this.hotlineCreateDate;
    return data;
  }
}

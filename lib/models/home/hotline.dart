class Hotline {
  Hotline({
    required this.data,
    required this.error,
  });
  late final List<Data> data;
  late final bool error;

  Hotline.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['error'] = error;
    return _data;
  }
}

class Data {
  var title;

  var hotline_id;

  Data({
    required this.hotlineId,
    required this.hotlineAppId,
    required this.hotlineUserId,
    required this.hotlineCat,
    required this.hotlineName,
    required this.hotlineDetail,
    required this.hotlinePhone,
    required this.hotlineUpdateDate,
    required this.hotlineCreateDate,
  });
  late final String hotlineId;
  late final String hotlineAppId;
  late final String hotlineUserId;
  late final String hotlineCat;
  late final String hotlineName;
  late final String hotlineDetail;
  late final String hotlinePhone;
  late final String hotlineUpdateDate;
  late final String hotlineCreateDate;

  Data.fromJson(Map<String, dynamic> json) {
    hotlineId = json['hotline_id'];
    hotlineAppId = json['hotline_app_id'];
    hotlineUserId = json['hotline_user_id'];
    hotlineCat = json['hotline_cat'];
    hotlineName = json['hotline_name'];
    hotlineDetail = json['hotline_detail'];
    hotlinePhone = json['hotline_phone'];
    hotlineUpdateDate = json['hotline_update_date'];
    hotlineCreateDate = json['hotline_create_date'];
  }

  get detail => null;

  get view => null;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hotline_id'] = hotlineId;
    _data['hotline_app_id'] = hotlineAppId;
    _data['hotline_user_id'] = hotlineUserId;
    _data['hotline_cat'] = hotlineCat;
    _data['hotline_name'] = hotlineName;
    _data['hotline_detail'] = hotlineDetail;
    _data['hotline_phone'] = hotlinePhone;
    _data['hotline_update_date'] = hotlineUpdateDate;
    _data['hotline_create_date'] = hotlineCreateDate;
    return _data;
  }
}
